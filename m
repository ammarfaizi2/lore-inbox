Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287022AbRL2AUd>; Fri, 28 Dec 2001 19:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285006AbRL2AUX>; Fri, 28 Dec 2001 19:20:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284905AbRL2AUQ>; Fri, 28 Dec 2001 19:20:16 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sat, 29 Dec 2001 00:30:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C2CD326.100@athlon.maya.org> from "Andreas Hartmann" at Dec 28, 2001 09:16:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K7Om-0002QI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Fix the VM-management in kernel 2.4.x. It's unusable. Believe
> 	me! As comparison: kernel 2.2.19 didn't need nearly any swap for
> 	the same operation!
> The performance of kernel 2.4.18pre1 is very poor, which is no surprise, 
> because the machine swaps nearly nonstop.

Does the 2.4.9 Red Hat kernel (if yoiu are using RH) or 2.4.12-ac8 show the 
same problem ?
