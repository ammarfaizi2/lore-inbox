Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272053AbRHVRUx>; Wed, 22 Aug 2001 13:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272050AbRHVRUn>; Wed, 22 Aug 2001 13:20:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60686 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272049AbRHVRUe>; Wed, 22 Aug 2001 13:20:34 -0400
Subject: Re: Kernel Locking Up
To: travis@pobox.com (Travis Shirk)
Date: Wed, 22 Aug 2001 18:23:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net> from "Travis Shirk" at Aug 22, 2001 09:46:14 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZbjI-0001s2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The symptons are total lock-up of the machine.  No mouse
> movement, all GUI monoitors freeze, and I cannot switch to a
> virtual console.  I'm not able to ping the locked machine or
> ssh/telnet into it either.  So I'm left wondering....how and
> the hell to I debug this problem.  It'd be nice to have some
> more information to go on or post to the list.

Can you get it to crash when you are not in X11 at all ?
