Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269672AbRHIFGC>; Thu, 9 Aug 2001 01:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269673AbRHIFFw>; Thu, 9 Aug 2001 01:05:52 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:23817 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S269672AbRHIFFm>;
	Thu, 9 Aug 2001 01:05:42 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: summary Re: encrypted swap
Date: 9 Aug 2001 05:02:41 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9kt5hh$8fo$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com> <3B70E4C8.2020400@blue-labs.org> <041d01c1205a$5afd9c00$0b32a8c0@playnet.com> <3B7217FF.3060104@blue-labs.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 997333361 8696 128.32.45.153 (9 Aug 2001 05:02:41 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Aug 2001 05:02:41 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford  wrote:
>Encrypted swap isn't a complete solution either.

No, of course not.  It's not a silver bullet, but it's still a useful tool.
(I assumed this would be obvious?)

>In any given case, physical access renders most solutions void or 
>significantly paled.

No, I dispute this.  I keep giving examples where encrypted swap can still
be useful even (or especially) when there is a risk that an attacker might
gain access to the machine occasionally.  I like to think my examples should
have been pretty clear, but if not, please ask, and I'll be happy to
elaborate on whichever point you found unclear.

(It is certainly true that if the attacker will have continuous physical
access to your machine in eternity, security is impossible, and encrypted
swap doesn't help.  But this doesn't change anything: This is not the
typical threat model, and there are very common scenarios where encrypted
swap *does* seem likely to help.)
