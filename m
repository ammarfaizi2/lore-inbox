Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTJOPZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJOPZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:25:07 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:16769
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263418AbTJOPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:25:05 -0400
Date: Wed, 15 Oct 2003 11:24:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Peter Maersk-Moller <peter@maersk-moller.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
In-Reply-To: <3F8D3A47.1000804@maersk-moller.net>
Message-ID: <Pine.LNX.4.53.0310151124180.2328@montezuma.fsmlabs.com>
References: <3F8D1377.3060509@maersk-moller.net> <3F8D3A47.1000804@maersk-moller.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Peter Maersk-Moller wrote:

> Hi
> 
> More info on the subject. It turns out that a 2.4.22 kernel
> without SMP-support but with IO-APIC enabled will also lock-up/stop
> when it installs the aic7xxx driver upon boot. Disabling the IO-APIC
> and disabling SMP-support makes the kernel boot normally.

How about UP and IO-APIC?

