Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263112AbTCSSkq>; Wed, 19 Mar 2003 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCSSkp>; Wed, 19 Mar 2003 13:40:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:29634 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263112AbTCSSko>;
	Wed, 19 Mar 2003 13:40:44 -0500
Date: Wed, 19 Mar 2003 10:51:35 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
Message-Id: <20030319105135.1fe21020.akpm@digeo.com>
In-Reply-To: <3E78B226.6050908@mvista.com>
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
	<3E78384A.6040406@mvista.com>
	<20030319014230.3412298e.akpm@digeo.com>
	<3E78B226.6050908@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 18:51:32.0980 (UTC) FILETIME=[8F589B40:01C2EE48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Andrew Morton wrote:
> > george anzinger <george@mvista.com> wrote:
> > 
> >>The attached patch is for 2.5.65.  As of this moment, the bk patch has 
> >>not been posted to the snapshots directory.  I will wait for that to 
> >>update.
> > 
> > 
> > Don't use the snapshots directory.  Use
> > 
> > 	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/
> 
> but then I need to pull each patch ... :)
> 

No.  The link at the top:

	"Gzipped full patch from v2.5.65 to ChangeSet 1.1171" 

is the diff from 2.5.65 to tip-of-tree.
