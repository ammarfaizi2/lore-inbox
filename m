Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVGGPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVGGPkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVGGPiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:38:11 -0400
Received: from cartier.jerryweb.org ([80.68.90.16]:32776 "EHLO
	cartier.jerryweb.org") by vger.kernel.org with ESMTP
	id S261296AbVGGPgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:36:15 -0400
Message-ID: <1120750556.42cd4bdc7101c@webmail.jerryweb.org>
Date: Thu, 07 Jul 2005 16:35:56 +0100
From: Jeremy Laine <jeremy.laine@polytechnique.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
References: <1120644686.42cbae4e16ea3@webmail.jerryweb.org> <200507061859.40565.adobriyan@gmail.com> <1120724705.42cce6e1e33c3@webmail.jerryweb.org> <42CD4667.9050205@brturbo.com.br>
In-Reply-To: <42CD4667.9050205@brturbo.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 195.115.41.103
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First of all, many thanks for taking the time to reply to my email!

> We don't have any other OOPS reported for BTTV cards.

The reply from Bodo Eggert seems to indicate otherwise..

Here is some extra information as requested:

> 	1) desactivate any overclocking at motherboard/video board;

I do not use any kind of overclocking, never have done and never will!

> 	2) use a standard vanilla kernel (not a distro kernel, that may have
> some experimental patches applied;

The crashes I reported were on a vanilla 2.6.12 kernel, compiled straight from
the tarball on kernel.org.

> 	3) use a minimum ammount of cards leaving only neccessary cards at MB.
> For these, it is good to clean its contacts;

The only extension cards I use are:
- 1 nVidia GeForce 6800 video adapter
- 1 Pinacle PCTV card
- 1 3Com 3c905C ethernet card
- 1 SB Live! 1024 card

I regularly vacuum-clean my tower and have checked the contacts on the extension
cards on several occasions. For tests, I am willing to remove the NIC +
soundcard if you think that will help (will try over the weekend), but in the
long run I don't consider any of the above cards to be "exotic" or optional..

> 	4) Test it again.

Will do, as stated above.  On a sidenote, so far I have been unable to reproduce
the problem when PREEMPT is disactivated (I stressed my box by compiling a
kernel while watching TV).

Cheers,
Jeremy

--
http://www.jerryweb.org/             : JerryWeb.org
http://sailcut.sourceforge.net/      : Sailcut CAD
http://opensource.polytechnique.org/ : Polytechnique.org Free Software
