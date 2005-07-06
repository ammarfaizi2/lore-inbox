Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVGFBCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVGFBCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVGFBCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:02:19 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:45220 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261996AbVGFBCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:02:15 -0400
Date: Tue, 5 Jul 2005 18:02:09 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, douglas_warzecha@dell.com
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-Id: <20050705180209.6ed75b2c.rdunlap@xenotime.net>
In-Reply-To: <20050706001333.GA3569@sysman-doug.us.dell.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 19:13:34 -0500 Doug Warzecha wrote:

| This patch adds the Dell Systems Management Base driver.
| 
| The Dell Systems Management Base driver is a character driver that
| implements ioctls for Dell systems management software to use to
| communicate with the driver.  The driver provides support for Dell
| systems management software to manage the following Dell PowerEdge
| systems: 300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC,
| 650, 1655MC, 700, and 750.
| 
| By making a contribution to this project, I certify that:
| The contribution was created in whole or in part by me and
| I have the right to submit it under the open source license
| indicated in the file.

Could you possibly reply to some earlier comments that have been posted
from Chris Wedgwood and me (and possibly others) instead of
ignoring them?

e.g.,
http://marc.theaimsgroup.com/?l=linux-kernel&m=111984209416906&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=111966319714417&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=111895964717480&w=2
and others.

Thanks,
---
~Randy
