Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbRF1Kdo>; Thu, 28 Jun 2001 06:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265629AbRF1Kde>; Thu, 28 Jun 2001 06:33:34 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:28016 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S265628AbRF1Kd2>; Thu, 28 Jun 2001 06:33:28 -0400
Date: Thu, 28 Jun 2001 11:19:37 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
Reply-To: Bjorn Wesen <bjorn@sparta.lu.se>
To: lar@cs.york.ac.uk
cc: linux-kernel@vger.kernel.org
Subject: RE: Cosmetic JFFS patch.
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com>
Message-ID: <Pine.LNX.3.96.1010628105039.30572A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Laramie Leavitt wrote:
> > dmesg buffer space is rather limited and IMHO there isn't space to
> > waste on credit-giving in boot logs.
> 
> Here here.  You don't see annoying log-eating copyright messages
> printed out in the Windows boot. Just imagine:

There's a difference; someone paid for that Windows code and you paid to
get windows and don't care about who did what. But when someone puts down
a lot of work to contributes something for free which others find useful
and actually use, don't you think it might be prudent to let them at least
write who contributed it, if a line is going to be printed anyway to say
device that or that has been registred ?

I know it sounds a bit like an "advertisment space" but it's always been
so; people have been releasing code for free since noone knows how long
and often one major factor has been that their peers will go "wow did
you do that". Otherwise why would anyone ever write their name in an About
box when they release a freeware program. And dmesg is the Linux kernels
About box (someone might argue that the code is the about box but
unfortunately most people dont read the headers in every .c file they
use).

See the old BSD license - distribution-wise it's more free than the GPL
but you still had to give credit where credit is due when getting a free
lunch from someone elses work (I think this requirement was dropped in the
current BSD license)

The risk is that some people might take it quite personally to get their
names removed and might not be as interested to see their code in the
kernel in the future. Of course as long as it's GPL nothing would stop it
anyway, but I still think it's a good idea to give credit for others hard
work.

/Bjorn

