Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVCPEjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVCPEjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCPEjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:39:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:51137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbVCPEj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:39:28 -0500
Date: Tue, 15 Mar 2005 20:39:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
Message-Id: <20050315203914.223771b2.akpm@osdl.org>
In-Reply-To: <4237A5C1.5030709@sbcglobal.net>
References: <4237A5C1.5030709@sbcglobal.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
>
> This isn't limited to the ACPI case.  My BIOS is old enough that ACPI is 
>  not supported because the kernel can't find RSDP.  I found that the USB 
>  works if I boot with "noapic."  This is probably sub-optimal on an SMP 
>  machine.  If don't boot with "noapic" I get the following errors:

Did it work OK under previous kernels?  If so, which versions?
