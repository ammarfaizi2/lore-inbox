Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTIGLzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 07:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbTIGLzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 07:55:48 -0400
Received: from babsi.intermeta.de ([212.34.184.3]:4102 "EHLO mail.intermeta.de")
	by vger.kernel.org with ESMTP id S263195AbTIGLzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 07:55:47 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Henning Schmiedehausen <hps@intermeta.de>
Reply-To: hps@intermeta.de
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0309051231110.13584-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0309051231110.13584-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Organization: INTERMETA - Gesellschaft  =?ISO-8859-1?Q?=20f=C3=BCr?= Mehrwertdienste mbH
Message-Id: <1062935718.5167.0.camel@uzi.hutweide.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Sep 2003 13:55:18 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.2 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 18:43, Ricky Beam wrote:

On 5 Sep 2003, Henning Schmiedehausen wrote:
> >225kpps * 64 Bytes (minimum packet len) = 13,7 MBytes / sec
> >
> >100 MBit / 8 bit = 12,5 MBytes / sec
> >
> >So, IMHO even with a small packet saturated 100 MBit link you won't
> >reach 225kpps. AFAIK this was Ciscos intention to publish this number.
> >It basically says "you will have filled your link before you fill our
> >router".
> 
> 64B is the minimum ETHERNET frame size.  That isn't true for PPP, HDLC,
> Frame relay, ATM, etc.

We were talking 100 MBit Ethernet, weren't we? ;-)

	Regards
		Henning


