Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752913AbWKLTgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbWKLTgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbWKLTgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:36:14 -0500
Received: from bay0-omc2-s11.bay0.hotmail.com ([65.54.246.147]:22932 "EHLO
	bay0-omc2-s11.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1752913AbWKLTgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:36:13 -0500
Message-ID: <BAY20-F24A945741EAE00E4980CEAD8F50@phx.gbl>
X-Originating-IP: [80.178.43.168]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061112173103.GA14005@flint.arm.linux.org.uk>
From: "Burman Yan" <yan_952@hotmail.com>
To: rmk+lkml@arm.linux.org.uk
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
Date: Sun, 12 Nov 2006 21:36:12 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Nov 2006 19:36:13.0697 (UTC) FILETIME=[D03C0F10:01C70691]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK.
Sorry.

I had to attach the patch, since hotmail does line wrapping, but I will note 
the part regarding
the more descriptive subject.

Also, some of the patches are one line per file, so I joined them together 
in one single patch.
I thought that splitting that into many tiny patches will actually be more 
annoying than
a single bigger patch.

Does that mean I should send those patches again?

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Burman Yan <yan_952@hotmail.com>
>CC: trivial@kernel.org, linux-kernel@vger.kernel.org
>Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
>Date: Sun, 12 Nov 2006 17:31:03 +0000
>
>On Sun, Nov 12, 2006 at 07:20:53PM +0200, Burman Yan wrote:
> > This is the first part of the patches I made that do trivial change of
> > replacing
> > kmalloc and memset with kzalloc
>
>Please follow the guidelines in SubmittingPatches in the kernel source
>when sending patches out.  You must not expect everyone here to read
>each of the attachments in your messages in detail to work out whether
>they need to do something with it or not.
>
>--
>Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

