Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFMHCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFMHCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVFMHCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:02:43 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:34518 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261395AbVFMHCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:02:41 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: subbie subbie <subbie_subbie@yahoo.com>, linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2005 00:02:34 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: optional delay after partition detection at boot time
In-Reply-To: <20050613041705.GD8907@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0506122358460.4268@qynat.qvtvafvgr.pbz>
References: <20050612071213.GG28759@alpha.home.local>
 <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
 <20050612102726.GA8470@alpha.home.local> <Pine.LNX.4.62.0506121919310.3896@qynat.qvtvafvgr.pbz>
 <20050613041705.GD8907@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting. How many total partitions do you have ? I ask this because
> David Alan Gilbert proposed a patch to dump the partition list on the
> screen upon panic. Perhaps it's larger than the screen in you case ? If
> you have more than 25 partitions, to you think they can fit with 2 or 3
> columns ?

This machine has 16 SATA drives with 1 partition each plus a (hardware) 
mirrored pair of SCSI drives with 4 partions, so only 20 partitions total 
in my config. however there are people who use more drives then this.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
