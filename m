Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273701AbRIWX6y>; Sun, 23 Sep 2001 19:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRIWX6p>; Sun, 23 Sep 2001 19:58:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36357 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273701AbRIWX60>; Sun, 23 Sep 2001 19:58:26 -0400
Subject: Re: EMU10k1 Driver
To: mkoch@synitech.com (Matthew Koch)
Date: Mon, 24 Sep 2001 01:03:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32832.65.11.238.48.1001284227.squirrel@mail.synitech.com> from "Matthew Koch" at Sep 23, 2001 06:30:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lJE0-0000qo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mistaken.  In addition to that, sound quality is poor and the mixer is not
> displaying all the options, specifically digital1 and digital2, the front
> and rear outputs.  I'm writing here because the code itself has no contacts
> listed as far as I found.  Are there any known fixes to this?  Thank you.

The sigmatel mixer ident is right actually. The rest is best fixed by 
copying the 2.4.7 driver over
