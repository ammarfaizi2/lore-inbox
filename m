Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275094AbRIYQpy>; Tue, 25 Sep 2001 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275092AbRIYQpo>; Tue, 25 Sep 2001 12:45:44 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:19718 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275093AbRIYQp2>; Tue, 25 Sep 2001 12:45:28 -0400
Message-ID: <3BB0B499.D39531A6@t-online.de>
Date: Tue, 25 Sep 2001 18:45:13 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@perex.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@cs.uit.no>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: IRDA support for NSC8739x LPC Super I/O chipsets
In-Reply-To: <Pine.LNX.4.31.0109251311070.3643-200000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> 
> Hello,
> 
>         I've attached a patch for NSC8739x LPC Super I/O chipsets to
> enable and configure the IRDA port. It works perfectly with my notebook
> over a half of year but the FIR transfers has not been tested yet. It
> would be nice to include this code to the official linux kernel tree.
> Thank you.

This should probably go to user space, too

Can't you set "IR" in your notebook BIOS? Then try "lspnp"
and a serial port should disappear if favour of infrared.

-
Gunther
