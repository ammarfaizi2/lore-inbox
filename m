Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTKSPaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTKSPaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 10:30:15 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:42383 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264118AbTKSPaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 10:30:11 -0500
From: JYC <jyc@despammed.com>
Subject: Re: Linux 2.4.23-rc2
To: linux-kernel@vger.kernel.org
Reply-To: jyc@despammed.com
Date: Wed, 19 Nov 2003 10:29:40 -0500
References: <TzDJ.7jl.21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20031119153010.5D55F36C22@smtp.istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> 
> Hi,
> 
> Here it goes -rc2.
> 
> Important netfilter fixes, several ACPI fixes, few driver corrections
> (tulip, tg3, megaraid2), amongst others.
> 
> If no problems shows up this should become final in a few days.
> 

USB keyboard and mouse are not working on my KT133a. I am using
ACPI+UP_APIC, all is well with 2.4.22 . The relevant entries from my syslog
below.

travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=2 (error=-110)
travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=3 (error=-110)
travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=4 (error=-110)
travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=5 (error=-110)
travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=6 (error=-110)
travis kernel: usb_control/bulk_msg: timeout
travis kernel: usb.c: USB device not accepting new address=7 (error=-110)

Jean-Yves Coupal


