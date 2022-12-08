--userId에서 입력한 값 그리고 userPwd에서 입력한 값과 일치하는 회원 정보가 있는지 조회
--admin / 1234와 일치하는 회원 조회

select *
from member
where user_id='admin' and user_pwd=1234 and status = 'Y';

select * 
from notice;

delete member where user_id='q';

SELECT NOTICE_NO
      ,NOTICE_TITLE
      ,NOTICE_CONTENT
      ,USER_ID
      ,COUNT
      ,CREATE_DATE
FROM NOTICE N
JOIN MEMBER ON (N.NOTICE_WRITER = USER_NO)
WHERE N.STATUS='Y'
ORDER BY N.CREATE_DATE DESC;