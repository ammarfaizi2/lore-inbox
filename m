Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRBJNF6>; Sat, 10 Feb 2001 08:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbRBJNFs>; Sat, 10 Feb 2001 08:05:48 -0500
Received: from [203.36.158.121] ([203.36.158.121]:27531 "EHLO
	piro.kabuki.eyep.net") by vger.kernel.org with ESMTP
	id <S130618AbRBJNFm>; Sat, 10 Feb 2001 08:05:42 -0500
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
From: Daniel Stone <daniel@kabuki.eyep.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: Chris Mason <mason@suse.com>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
In-Reply-To: <20010211020200.A9570@metastasis.f00f.org>
In-Reply-To: <479040000.981564496@tiny>
	<E14QkfM-0004EL-00@piro.kabuki.eyep.net> 
	<20010211020200.A9570@metastasis.f00f.org>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 11 Feb 2001 00:05:12 +1100
Mime-Version: 1.0
Message-Id: <E14RZiG-0001s1-00@piro.kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb 2001 02:02:00 +1300, Chris Wedgwood wrote:
> On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
> 
>     I run Reiser on all but /boot, and it seems to enjoy corrupting my
>     mbox'es randomly.
> 
> what kind of corruption are you seeing?

Zeroed bytes.

>     This also occurs in some log files, but I put it down to syslogd
>     crashing or something.
> 
> syslogd crashing shouldn't corrupt files... 

Actually, I meant to say my hard drive crashing.
I have two hard drives, side-by-side, and sometimes they overheat and
one of them powers down due to the excess heat.
They haven't done that lately, though, as I have a dedicated fan for
both of them, but the corruption persists.

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
