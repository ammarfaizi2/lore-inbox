Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTGIIza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbTGIIza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:55:30 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37137 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265841AbTGIIz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 04:55:29 -0400
Subject: Re: ACPI status in 2.5.x/2.6.0
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Daniel <daniel@hawton.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0BD5D1.2010801@hawton.org>
References: <3F0BD5D1.2010801@hawton.org>
Content-Type: text/plain
Message-Id: <1057741803.584.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 11:10:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 10:44, Daniel wrote:
> I have a Compaq Laptop (*shiver*) and present distro versions featuring 
> the 2.4.x kernel seem to panic or lock on bootup on my laptop.  I was 
> wondering if ACPI was better supported in the 2.5.x kernel branch/2.6.0 
> pre-kernel.  Any advice would be greatly appreciated.
> 
> It would lock when attempting to read my partition table on device 'hda' 
> (my hard disk), or would panic when attempting to initalize the USB device.

I think the best you can do it's trying by yourself :-)
For me, ACPI in 2.5 kernels do work better than in 2.4.

