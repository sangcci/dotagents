# 좋은 테스트와 나쁜 테스트

## 좋은 테스트

**통합 스타일**: 내부 부품을 mock하지 않고 실제 인터페이스를 통해 테스트합니다.

```typescript
// 좋음: 관찰 가능한 동작을 테스트
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

특징:

- 사용자나 호출자가 관심 있는 동작을 테스트합니다.
- 공개 API만 씁니다.
- 내부 리팩터링에 살아남습니다.
- 어떻게가 아니라 무엇을 설명합니다.
- 테스트마다 논리적 단언은 하나입니다.

## 나쁜 테스트

**구현 세부 사항 테스트**: 내부 구조에 결합되어 있습니다.

```typescript
// 나쁨: 구현 세부 사항을 테스트
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

위험 신호:

- 내부 협력자를 mock합니다.
- private 메서드를 테스트합니다.
- 호출 횟수나 순서를 단언합니다.
- 동작은 그대로인데 리팩터링하면 테스트가 깨집니다.
- 테스트 이름이 무엇이 아니라 어떻게를 설명합니다.
- 인터페이스가 아니라 외부 수단으로 검증합니다.

```typescript
// 나쁨: 인터페이스를 우회해서 검증
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// 좋음: 인터페이스를 통해 검증
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```

**동어반복 테스트**: 기대값이 구현을 그대로 되풀이해서 구성상 항상 통과합니다.

```typescript
// 나쁨: 기대값을 코드가 계산하는 방식으로 다시 계산
test("calculateTotal sums line items", () => {
  const items = [{ price: 10 }, { price: 5 }];
  const expected = items.reduce((sum, i) => sum + i.price, 0);
  expect(calculateTotal(items)).toBe(expected);
});

// 좋음: 기대값이 독립된, 알려진 리터럴
test("calculateTotal sums line items", () => {
  expect(calculateTotal([{ price: 10 }, { price: 5 }])).toBe(15);
});
```
