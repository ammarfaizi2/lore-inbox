Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273019AbTHKTXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273257AbTHKTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:22:51 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:5565 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S273019AbTHKTWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:22:24 -0400
Message-ID: <3F37F1A4.2030404@genebrew.com>
Date: Mon, 11 Aug 2003 15:42:28 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Blazejowski <paulb@blazebox.homeip.net>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
References: <1060543928.887.19.camel@blaze.homeip.net>	 <2425882704.1060622541@aslan.btc.adaptec.com> <1060623576.2826.9.camel@blaze.homeip.net>
In-Reply-To: <1060623576.2826.9.camel@blaze.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blazejowski wrote:

> Is this due to my mainboard (nforce2),cpu,ACPI,devfs,sysfs...or all
> these together?

NForce2 + ACPI IRQ routing is a work in progress. Try turning off ACPI 
for the time being and see if it helps.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

