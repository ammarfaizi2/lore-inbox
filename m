Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRCABee>; Wed, 28 Feb 2001 20:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCAB2g>; Wed, 28 Feb 2001 20:28:36 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129441AbRCAB2U>;
	Wed, 28 Feb 2001 20:28:20 -0500
Subject: Re: time drift and fb comsole activity
To: cort@fsmlabs.com (Cort Dougan)
Date: Thu, 1 Mar 2001 00:04:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        morton@nortelnetworks.com (Andrew Morton), ebuddington@wesleyan.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010228165942.M28471@ftsoj.fsmlabs.com> from "Cort Dougan" at Feb 28, 2001 04:59:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YGZj-0006nh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> } The fbdev console problem is too horrible to pretend to solve by resyncing
> } on timer interrupts. At least for the x86 the fix is to sort out the fb
> } locking properly
> 
> How close is that?

Its not in itself a big problem, but since it doesnt reformat your hard disk,
explode randomly or drop you off the network its not at the top of my priority
list right now

