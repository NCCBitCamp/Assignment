package com.bit.springbootdemo.serivce.impl;

import com.bit.springbootdemo.dto.MemberDto;
import com.bit.springbootdemo.mapper.MemberMapper;
import com.bit.springbootdemo.serivce.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberServiceimpl implements MemberService {
    private final MemberMapper memberMapper;

    @Override
    public void join(MemberDto memberDto) {
        // 비지니스 로직 처리
        // 비밀번호 암호화 로직등을 처리한다.
        memberMapper.join(memberDto);

    }

    @Override
    public int memberCnt(MemberDto memberDto) {
        return memberMapper.memberCnt(memberDto);
    }

    @Override
    public Optional<MemberDto> login(MemberDto memberDto) {
        MemberDto loginMember = memberMapper.login(memberDto);

        if (loginMember == null) {
            return Optional.empty();
        }

        return Optional.of(loginMember);
    }

    @Override
    public List<MemberDto> memberList() {
        return memberMapper.memberList();
    }


}
