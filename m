Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWAaPd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWAaPd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWAaPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:33:26 -0500
Received: from [85.8.13.51] ([85.8.13.51]:56802 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750956AbWAaPd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:33:26 -0500
Message-ID: <43DF8349.9070908@drzeus.cx>
Date: Tue, 31 Jan 2006 16:33:29 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, dirk@opfer-online.de,
       jbowler@acm.org
Subject: Re: [PATCH 0/11] LED Class, Triggers and Drivers
References: <1138714882.6869.123.camel@localhost.localdomain>
In-Reply-To: <1138714882.6869.123.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> 
> Future Development
> ==================

A MMC trigger in the pipeline? My new SDHCI MMC driver can be built as a
LED device, but it should probably be mapped to MMC activity by default.

Rgds
Pierre

