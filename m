Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUHGWtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUHGWtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUHGWtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:49:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29636 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264561AbUHGWte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:49:34 -0400
Subject: Re: hda: dma_timer_expiry: dma status == 0x24
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41152B61.90702@blue-labs.org>
References: <41152B61.90702@blue-labs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091915230.19077.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 22:47:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-07 at 20:20, David Ford wrote:
> My desktop is experiencing issues with DMA lately.  This has been going 
> on with the 2.6.8-rcX releases IIRC.  I'm currently on rc3.  The 
> hardware is all brand new.

1. Does it recover after the timeout/lost irq
2. Does it occur with acpi=off
3. Have you tested say 2.4 or "otherOS" on it ?

