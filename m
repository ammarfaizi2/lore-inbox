Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKULyh>; Tue, 21 Nov 2000 06:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKULy1>; Tue, 21 Nov 2000 06:54:27 -0500
Received: from tartu.cyber.ee ([193.40.16.128]:4106 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S129091AbQKULyI>;
	Tue, 21 Nov 2000 06:54:08 -0500
From: Meelis Roos <mroos@linux.ee>
To: bcollins@debian.org, linux-kernel@vger.kernel.org
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
In-Reply-To: <20001120141641.Y619@visi.net>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.0-test10 (i586))
Message-Id: <E13yBXV-0000mZ-00@roos.tartu-labor>
Date: Tue, 21 Nov 2000 13:24:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Does kernel 2.4.x compile and run well for all of our supported archs?
>> 
>> AFAIK yes. At least on all Debian archs.

BC> So, sparc, ultrasparc, i386 (with pcmcia support), alpha, arm, m68k,
BC> powerpc? I know that mips, s390 and hppa almost require a 2.4.0 kernel,

m68k is not ready AFAIK. There are some experimental patches that make some
modesl work in 2.4 (mostly Geert's).

-- 
Meelis Roos (mroos@linux.ee)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
