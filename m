Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVHPEfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVHPEfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPEfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:35:09 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:149 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932601AbVHPEfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:35:08 -0400
X-ORBL: [63.205.185.3]
Date: Mon, 15 Aug 2005 21:34:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816043451.GA25224@taniwha.stupidest.org>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:

> Why can't you just implement the system management actions in the
> kernel driver?

Why put things in the kernel unless it's really needed?

I'm not thrillied about the lack of userspace support for this driver
but that still doesn't mean we need to shovel wads of crap into the
kernel.
