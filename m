Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSL2WbM>; Sun, 29 Dec 2002 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSL2WbM>; Sun, 29 Dec 2002 17:31:12 -0500
Received: from host194.steeleye.com ([66.206.164.34]:8461 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261900AbSL2WbL>; Sun, 29 Dec 2002 17:31:11 -0500
Message-Id: <200212292239.gBTMdPJ12407@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: hch@lst.de
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Dec 2002 16:39:25 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's only used to hide two entries in arch/i386/Kconfig.

The patch looks good.  If it's OK to get rid of X86_NUMA, could you also move 
X86_NUMAQ under the subarch menu?

Thanks,

James


