Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUKHSHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUKHSHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKHRFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:05:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16330 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261917AbUKHQOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:14:06 -0500
Subject: Re: Asus P5AD2Premium Intel 925 X Chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mws <mws@twisted-brains.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411081234.50035.mws@twisted-brains.org>
References: <200411081234.50035.mws@twisted-brains.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099926655.5567.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 15:10:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-08 at 11:34, mws wrote:
> hi,
> 
> if someone if coding on a driver for the Silicon Image Sil3114R and Intel ITE 8212F
> 
> or the soundchip/codec CMedia CMI 9880 i can provide them with information or testing support
> 
> from latest 15.11.2004 on.

The 3114 is already supported (use dmraid for its software raid). The
ITE 8212 is also supported in current -ac code. 

Alan

