Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSGKB53>; Wed, 10 Jul 2002 21:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317713AbSGKB52>; Wed, 10 Jul 2002 21:57:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317712AbSGKB52>; Wed, 10 Jul 2002 21:57:28 -0400
Subject: Re: [OT] /proc/cpuinfo output from some arch
To: thunder@ngforever.de (Thunder from the hill)
Date: Thu, 11 Jul 2002 03:22:44 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
       hpa@zytor.com (H. Peter Anvin), pavel@ucw.cz (Pavel Machek),
       acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207101744040.5067-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at Jul 10, 2002 05:45:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17STbQ-0008MP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, asymmetric multiprocessing is a much more diffcult field, but 
> it's not currently an issue to us. (Well, we had this issue long ago, but 
> the SMP approach won, because even though it's uncool, it's still easier 
> to handle. Maybe AMP will return one day...)

Per CPU clock ratios are supported in several places. There is also a whole
research field into SMP power management that goes with it
