Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRDNGDe>; Sat, 14 Apr 2001 02:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRDNGDZ>; Sat, 14 Apr 2001 02:03:25 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:40957 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132754AbRDNGDP>; Sat, 14 Apr 2001 02:03:15 -0400
Message-Id: <l03130307b6fd92802be1@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0104131932260.1502-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 14 Apr 2001 06:40:56 +0100
To: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: OOM killer *WORKS* for a change!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just ran netscape which for some reason or another went totally
>whacky and gobbled RAM.  It has done this before and made the box
>totally unuseable in 2.2.17-2.2.19 befor the kernel killed 90% of
>my running apps before getting the right one.  This time, it
>OOM'd and killed Netscape and I got control back instantly.  This
>is with 2.4.2.  I hope this is a good sign!

Maybe, but 2.4.2 and 2.4.3 are still using the "old" killer algorithms
which can behave erratically.  I haven't looked at 2.2.x OOM killers at
all, so I don't know how they compare.  At some point in the near future, I
want to separate my patches out so they can receive individual attention
and hopefully get applied.

BTW, on this subject, if anyone sent me a mail which I haven't replied to,
I probably never got it due to e-mail problems with my ISP.  If it's still
relevant, please resend.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


