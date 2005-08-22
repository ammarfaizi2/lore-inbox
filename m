Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVHVWWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVHVWWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVHVWWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:22:30 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45960 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751372AbVHVWW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:28 -0400
Date: Mon, 22 Aug 2005 11:12:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: greg@kroah.com, michael_e_brown@dell.com, matt_domsch@dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base Driver with sysfs support
Message-ID: <20050822091216.GA11888@elf.ucw.cz>
References: <20050820225052.GA5042@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820225052.GA5042@sysman-doug.us.dell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> This patch adds the Dell Systems Management Base Driver with sysfs support.
> 
> This patch incorporates changes based on comments from the previous
> posting.

Could we get some better name for this one?

> diff -uprN linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c linux-2.6.13-rc6/drivers/firmware/dcdbas.c
> --- linux-2.6.13-rc6.orig/drivers/firmware/dcdbas.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.13-rc6/drivers/firmware/dcdbas.c	2005-08-19

Like dell_mgmt.c?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
