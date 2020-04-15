//데이터 베이스 생성
create database boardtest;

//유저 테이블
create table USER (
 userID varchar(20),
 userPassword varchar(20),
 userName varchar(20),
 userGender varchar(20),
 userEmail varchar(50),
 primary key(userID)
);

//데이터 베이스 접근 
use boardtest

//테이블 테이터 확인
select * from USER;


//게시판 테이블 (boardAvailavle:글 삭제 여부 판단 1. 삭제가 되지 않은글, 0. 삭제된 글)
create table board(
boardID int,
boardTitle varchar(50),
userID varchar(20),
boardDate DATETIME,
boardContent varchar(2048),
boardAvailable INT, 
PRIMARY KEY (boardID)
);

