Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSK3V2m>; Sat, 30 Nov 2002 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSK3V2m>; Sat, 30 Nov 2002 16:28:42 -0500
Received: from zork.zork.net ([66.92.188.166]:48842 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S262838AbSK3V2m>;
	Sat, 30 Nov 2002 16:28:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with via82cxxx and vt8235
References: <200211300129.32580.black666@inode.at>
	<1038667380.17209.2.camel@irongate.swansea.linux.org.uk>
	<200211302227.23253.black666@inode.at>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DICTO SIMPLICITER, EXCRETORY SPEECH
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 30 Nov 2002 21:36:07 +0000
In-Reply-To: <200211302227.23253.black666@inode.at> (Patrick Petermair's
 message of "Sat, 30 Nov 2002 22:27:23 +0100")
Message-ID: <6uisye3flk.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Patrick Petermair quotation:

> Alan Cox:
>>
>> Try the -ac tree firstly
>
> Thanks Alan, now dma works perfect!
> How come this code isn't in the official 2.4.20 kernel?
>
> The only strange thing now is that uname doesn't know my cpu:
>
> starbase:/# uname -a
> Linux starbase 2.4.20-ac1 #1 Sam Nov 30 18:43:15 CET 2002 i686 unknown unknown GNU/Linux

Are you running Debian unstable, and did you recently dist-upgrade?
The changes to coreutils that display CPU information in place of
"unknown unknown" were reverted in coreutils 4.5.3-1.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
