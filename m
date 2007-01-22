Return-Path: <linux-kernel-owner+w=401wt.eu-S1751766AbXAVPoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXAVPoV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXAVPoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:44:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52784 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533AbXAVPoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:44:20 -0500
Date: Mon, 22 Jan 2007 15:53:26 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI seagate.c: remove SEAGATE_USE_ASM
Message-ID: <20070122155326.4b0dbf30@localhost.localdomain>
In-Reply-To: <20070122153813.GT9093@stusta.de>
References: <20070121191300.GL9093@stusta.de>
	<20070122151841.6d0473e4@localhost.localdomain>
	<20070122153813.GT9093@stusta.de>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The C codepaths are essentially untested on this driver.
> 
> Has any part of this driver ever be tested with kernel 2.6?
> Or compiled with gcc 4?

The C code paths have never been tested at all, the asm ones certainly
worked in late 2.4, but I don't; have an ISA box any more.
