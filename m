Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317655AbSFLHNz>; Wed, 12 Jun 2002 03:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSFLHNy>; Wed, 12 Jun 2002 03:13:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317655AbSFLHNx>; Wed, 12 Jun 2002 03:13:53 -0400
Subject: Re: linux 2.4.19-preX IDE bugs
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 12 Jun 2002 08:31:49 +0100 (BST)
Cc: nick@octet.spb.ru (Nick Evgeniev), andre@linux-ide.org (Andre Hedrick),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020611184236.29598B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jun 11, 2002 06:49:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I2bd-000732-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I agree that if it has known problems which destroy data it should be
> unavailable in the stable kernel. It certainly sounds as if that's the
> case, and the driver could be held out until 2.4.20 or so when it can be
> fixed, or if it can't be fixed it can just go away.

Then I suggest you give up computing, because PC hardware doesnt make
your grade. BTW the general open promise bugs *dont* include data
corruption so I suspect it may be your h/w thats hosed.
