Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285188AbRLSLdD>; Wed, 19 Dec 2001 06:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285243AbRLSLcx>; Wed, 19 Dec 2001 06:32:53 -0500
Received: from noc.easyspace.net ([62.254.202.67]:55044 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S285188AbRLSLcl>; Wed, 19 Dec 2001 06:32:41 -0500
Date: Wed, 19 Dec 2001 11:32:28 +0000
From: Sam Vilain <sam@vilain.net>
To: "Jesse W. Asher" <jasher1@tampabay.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ds: no socket drivers loaded! in 2.4.x
In-Reply-To: <3C1F7574.795C98A4@tampabay.rr.com>
In-Reply-To: <3C1F7574.795C98A4@tampabay.rr.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16GexY-0001zJ-00@hoffman.vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesse W. Asher" <jasher1@tampabay.rr.com> wrote:

> Sam, did you ever figure out what was causing this?  I'm having the
> exact same problem and ran across your post from October.  Any
> information you gathered would be appreciated!!  Thanks!!

Yep.  I said "Y" rather than "M" to the questions under "general
setup"..."PCMCIA/CardBus support" that applied to me.  The "sockets" it
refers to would be provided by either the cardbus support, or one of the
PCMCIA bridges.

I probably could have got away with the appropriate modprobe command, but
it seems to be out of fashion these days to include the name of the module
a kernel configuration option compiles to in the help text for that
option.

Sam.

cc:ed to the list for the benefit of people searching the net for this
problem ;)
