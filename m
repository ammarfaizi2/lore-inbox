Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946569AbWKJNAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946569AbWKJNAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946571AbWKJNAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:00:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946569AbWKJNAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:00:10 -0500
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
From: Arjan van de Ven <arjan@infradead.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061110123541.GA18001@stingr.net>
References: <20061109100953.GE2226@stingr.net>
	 <20061109204145.56d02153.akpm@osdl.org> <20061110123541.GA18001@stingr.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 14:00:03 +0100
Message-Id: <1163163603.3138.700.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 15:35 +0300, Paul P Komkoff Jr wrote:
> ce: <Cronyx Tau-PCI/32-Lite> at 0xfb013000 irq 217

what kind of device is this? Did the driver come with the kernel?


Also have you tried acpi=off or the linux firmware test kit (see url in
sig) to check the bios?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

