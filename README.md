## 사용방법 
- 상단의 "검색어를 입력하세요" 클릭
- 찾고자 하는 지역을 검색
- submit or 엔터 -> 여러개의 marker 생성, 그 중 첫번째 항목으로 카메라 이동
- 리스트 클릭 -> 한개의 Marker 생성, 해당 항목으로 카메라 이동

## 에러사항!!!
**특정 검색 구간에서 에러가 발생함**
- 자양역 엔터 , 서울역 클릭 , 자양역 엔터 -> Thread 1: signal SIGABRT
- 서울역 클릭 , 맥도날드 엔터 , 서울역 엔터 -> Thread 1: EXC_BAD_ACCESS (code=1, address=0xd9)
  
** 항상 3번째 검색에서 에러가 발생 **

** 쓰레드 문제인거 같은데 뭐가 문제인지 모르겠음 **

## 특이사항
- MapCameraPosition 사용 ( iOS 17 + )
- Annotation 대신 Marker 사용 ( iOS 17 + )
- MKLocalSearchCompleterDelegate 사용
- CLLocationManager 사용 안했는데, 현재 위치 업데이트 가능

## 못한 것, 궁금한 것
- Async throws 함수 error 처리
- Task로 비동기 작업시 포함 시켜야 할 것 (ex. dismiss 는 Task 안에 넣어야하나?)
- Identifiable 과 Hashable 의 차이
- Results 를 초기화 하는 과정을 넣어주어야 하나?





  



