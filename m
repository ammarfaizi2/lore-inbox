Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUL2VAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUL2VAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUL2VAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:00:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27300 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261406AbUL2VAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:00:45 -0500
Subject: Re: Patch: 2.6.10 - CMSPAR in mxser.c undeclared
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Norbert Tretkowski <tretkowski@inittab.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041229081957.GA31981@rollcage.inittab.de>
References: <20041229081957.GA31981@rollcage.inittab.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104331638.30080.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 19:56:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 08:19, Norbert Tretkowski wrote:
> {standard input}: Assembler messages:
> {standard input}:5: Warning: setting incorrect section attributes for .got
> drivers/char/mxser.c: In function `mxser_ioctl_special':
> drivers/char/mxser.c:1564: error: `CMSPAR' undeclared (first use in this function)
> drivers/char/mxser.c:1564: error: (Each undeclared identifier is reported only once
> drivers/char/mxser.c:1564: error: for each function it appears in.)

What environment/architecture are you building this on (having built it
myself just fine ?)

Alan

