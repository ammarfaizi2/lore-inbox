Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUBEQ2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUBEQ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:28:21 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:63882 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266321AbUBEQ1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:27:49 -0500
Subject: Re: questin about switch off
From: Ludootje <ludootje@linux.be>
To: Roman Jordan <RomanJordan@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1075932364.2952.112.camel@darkstar>
References: <1075932364.2952.112.camel@darkstar>
Content-Type: text/plain
Message-Id: <1076002007.4190.14.camel@gax.mynet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 17:26:50 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC that had something with using or APM (Advanced Power
Management) or not. I think that if you enable it in the kernel,
halt/poweroff/shutdown will work fine.

Ludootje

On Wed, 2004-02-04 at 22:06, Roman Jordan wrote:
> Hi,
> i use a sony laptop with kernel 2.6.1 and acpi support. If i want do
> switch it off the device, using the command 'halt' or 'poweroff' the
> laptop does not switch off. I only get the message 'system haltet'. If
> use the kernel without ACPI, the display is drawing black, but the
> device is also not swiched off.
> If i using the fedora standard kernel 2.4.22-1.2115.nptl the 'halt'
> command works fine.
> Any ideas?
> 
> Regards,
> Roman Jordan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

