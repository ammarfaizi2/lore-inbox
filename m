Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287538AbRLaPWZ>; Mon, 31 Dec 2001 10:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287540AbRLaPWQ>; Mon, 31 Dec 2001 10:22:16 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:53512 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S287539AbRLaPWH>; Mon, 31 Dec 2001 10:22:07 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "samson swanson" <intellectcrew@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: prog for no OS. language?
Date: Mon, 31 Dec 2001 07:22:12 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBKEPKEEAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011231075235.66176.qmail@web14309.mail.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hello,
>
> I had a quick question. Say I want to write a program
> to run without an OS, what language/tools do i need?

Well ... *my* personal preference for such things is Forth :-). Forth runs
even on such "tiny" machines as 8051 micro-controllers and there are
probably a dozen good Forth environments, ranging in cost from free to
thousands of US dollars. I have Forth, Inc. SwiftForth for Windows, but for
what you want, you might head over to

http://www.taygeta.com/forthcomp.html

for a comprehensive list of Forth compilers and tutorial information. There
is a Gnu / GPL Forth called "gforth" that will run on Linux (and Windows)
but I've never used it, so I can't comment on it. Other Forth folk have told
me that it's inferior to their own pet versions.

Obligatory warning for those with families: like Linux kernel hacking, Forth
hacking on small computers that can barely support a hex keypad, let alone
an OS, is *highly addictive*! <vbg>

: TARGET  FOOT FIND ;
: LOAD  BULLET FIND CHAMBER INSERT ;
: SHOOT  LOAD  TARGET  GUN AIM  TRIGGER PULL ;

--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

