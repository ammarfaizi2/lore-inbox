Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTILNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 09:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbTILNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 09:54:58 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:40159 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261689AbTILNy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 09:54:57 -0400
Date: Fri, 12 Sep 2003 15:54:55 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA proprietary driver problem
In-Reply-To: <87u17if7eu.fsf@nausicaa.krose.org>
Message-ID: <Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv>
References: <87u17if7eu.fsf@nausicaa.krose.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Can't find an IRQ for your NVIDIA card!
> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Please check your BIOS settings.
> Sep 11 23:37:57 nausicaa kernel: 0: nvidia: [Plug & Play OS   ] should be set to NO
I wonder why pnp os should be off?
Linux does support pnp, and is a pnp os. Isn't it?

Have you tried disabling apic? Maybe it's an apic or irq routing bug?
What motherboard is it?

Regards,
Maciej
