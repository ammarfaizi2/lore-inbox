Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311879AbSDFQHN>; Sat, 6 Apr 2002 11:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSDFQHM>; Sat, 6 Apr 2002 11:07:12 -0500
Received: from [151.200.199.52] ([151.200.199.52]:21517 "EHLO
	fc2.capaccess.org") by vger.kernel.org with ESMTP
	id <S311879AbSDFQHK>; Sat, 6 Apr 2002 11:07:10 -0500
Message-id: <fc.00858412003a3fa600858412003a290a.3a3fb6@capaccess.org>
Date: Sat, 06 Apr 2002 11:05:32 -0500
Subject: Re: RE: Forth interpreter as kernel module
To: znmeb@aracnet.com
Cc: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEOCEKAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yes, Phil Burk is still doing music ... no, he's not doing it in Forth,
but
>in Java. Hunt up "jmsl" and "jsyn" for the details. I haven't heard much

That's disturbing. And Phil was such a NICE guy. He was telling me about
some FPGA devkit and described it as "HOURS of fun." <solemnly removes hat>

>Well, I want a full-strength Forth in my Linux box -- I've got SwiftForth
>Pro on my Windows system and I'm holding out for something of that
>comprehensive nature on Linux. I have to admit I haven't played with the
>gForth that I think comes with my Red Hat distro, so I don't know what
it's
>like.

I don't know if you want a SwiftForth/VFX/GForth/BigForth/iForth _IN_ your
Linux kernel though. The advantage of unix over WinDoS is that if you have
all the syscalls, which isn't much code, you're not missing much. This is
why I did libsys.a, and two Forths with all the syscalls.

>I've heard hard-core Forthers gag profusely at the mere mention of
>gForth.
>

I hadn't heard that. I think I qualify as a hardcore Forther, which is
probably based on writing your own bizarre Forth variant. GForth isn't
anything to gag about. Bernd and Anton are both perfectly brilliant. I
think, like most large Forths, it depends on locals too soon, and the
emacs tendencies are not to my tastes, but that's superficial, and that's
to be expected for a/the GNU Forth. The threading scheme in the first
H3sm, in Gcc, I lifted straight from GForth; labels-as-values and so on.
GForth is nice, and real close to ANSI.

>So, enough "old Forthers home week" on the Linux kernel mailing list, eh?

It could soon be "New Forthers Bum-Rush Week" in the Linux kernel. Some of
the old guys might like to know they weren't shooting blanks. Haas in
particular had rather unixy tastes for the time. He was the files side of
the great files/blocks flamewar. JForth has atrocities like #include and
so on. JForth is PD now, BTW.

>: TOOT FORTH LOVE IF HONK THEN ;

TOOT
HOOOOOOOOOOOOOOOOONK OK

Rick Hohensee

>--
>M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
>http://www.borasky-research.net  http://www.aracnet.com/~znmeb
>mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com
>
>Q. Who invented the non-Von Neumann computer architecture?
>A. John non-Von Neumann.

Actually it was a Forth guy, Von John Neumann Non.


