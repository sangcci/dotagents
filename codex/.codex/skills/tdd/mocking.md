# mock을 쓸 때

시스템 경계에서만 mock합니다.

- 외부 API(결제, 이메일 등)
- 데이터베이스(경우에 따라, 테스트 DB를 우선)
- 시간과 난수
- 파일시스템(경우에 따라)

mock하지 않는 것:

- 직접 만든 클래스와 모듈
- 내부 협력자
- 직접 통제하는 모든 것

## mock하기 쉬운 설계

시스템 경계에서는 mock하기 쉬운 인터페이스를 설계합니다.

**1. 의존성 주입을 씁니다**

외부 의존성은 안에서 만들지 않고 밖에서 넘겨받습니다.

```typescript
// mock하기 쉬움
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// mock하기 어려움
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. 범용 fetcher보다 SDK 스타일 인터페이스를 선호합니다**

조건 분기가 든 범용 함수 하나가 아니라, 외부 연산마다 구체적인 함수를 만듭니다.

```typescript
// 좋음: 각 함수를 독립적으로 mock할 수 있음
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// 나쁨: mock 안에 조건 분기가 필요함
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK 방식의 이점:

- mock이 구체적인 한 가지 형태만 반환합니다.
- 테스트 준비에 조건 분기가 들어가지 않습니다.
- 테스트가 어떤 엔드포인트를 쓰는지 한눈에 보입니다.
- 엔드포인트마다 타입 안전성이 생깁니다.
