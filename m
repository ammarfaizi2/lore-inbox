Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUGPJQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUGPJQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUGPJQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:16:36 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56475 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266502AbUGPJQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:16:20 -0400
Subject: Re: [patch] MTD: add st m50fw0* to jedec_probe.c
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406020642310.16424@skynet>
References: <Pine.LNX.4.58.0406020642310.16424@skynet>
Content-Type: text/plain
Message-Id: <1089969377.8822.177.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 16 Jul 2004 10:16:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 06:46 +0100, Dave Airlie wrote:
> Please ignore my last patch, my hardware guy pointed me at some more
> chips,
> 
> so this patch adds support to the jedec probe for ST M50FW040, M50FW080
> and M50FW016 all Firmware hubs for i8x0 chipsets,

AFAICT those three are all already in CVS and in Linus' current
BitKeeper tree.

-- 
dwmw2


