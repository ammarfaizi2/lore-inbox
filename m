Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130284AbRBSBrR>; Sun, 18 Feb 2001 20:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbRBSBq5>; Sun, 18 Feb 2001 20:46:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60686 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130469AbRBSBqu>; Sun, 18 Feb 2001 20:46:50 -0500
Subject: Re: Linux OS boilerplate
To: smlong@teleport.com (Scott Long)
Date: Mon, 19 Feb 2001 01:47:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A902F77.8BF6AB52@teleport.com> from "Scott Long" at Feb 18, 2001 12:24:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UfQ8-00027g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been poring over the x86 boot code for a while now and I've been
> considering writing a FAQ on the boot process (mostly for my own use,
> but maybe others will be interested). This would include all relevant
> information on setting up the x86 hardware for a boot (timers, PIC, A20,
> protected mode, GDT, initial page tables, initial TSS, etc).

It would certainly be a valuable piece for the kernel Documentation dir.
Paticularly as people with embedded x86 grow keener and keener to boot 
biosless to save money and flash.

