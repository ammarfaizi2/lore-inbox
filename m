Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFTMBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFTMBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVFTMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 08:01:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3479 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261211AbVFTMBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 08:01:19 -0400
Date: Mon, 20 Jun 2005 11:56:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, abhay_salunke@dell.com,
       matt_domsch@dell.com
Subject: Re: [PATCH 2.6.12-rc6] char: Add Dell Systems Management Base driver
Message-ID: <20050620095657.GA3312@elf.ucw.cz>
References: <20050616173024.GA2596@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616173024.GA2596@sysman-doug.us.dell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds the Dell Systems Management Base driver.
> 
> The Dell Systems Management Base driver is a character driver that
> provides support needed by Dell systems management software to manage
> certain Dell systems.  The driver implements ioctls for Dell systems
> management software to use to communicate with the driver.

Don't test KERNEL_VERSION; you already know it is better than 2.6.


								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
