Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTAaWK2>; Fri, 31 Jan 2003 17:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTAaWK2>; Fri, 31 Jan 2003 17:10:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:16106 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262500AbTAaWK1>;
	Fri, 31 Jan 2003 17:10:27 -0500
Date: Fri, 31 Jan 2003 14:22:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm7 results with database 'benchmark'
Message-Id: <20030131142213.37020b31.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301311641050.17695-100000@admin>
References: <Pine.LNX.4.44.0301311641050.17695-100000@admin>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 22:19:47.0355 (UTC) FILETIME=[DD28AEB0:01C2C976]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield <lkml@dm.cobite.com> wrote:
>
> 
> The (slight) advantage that the 2.5.59 series had over the RedHat
> kernels has evaporated.  But it was marginal to begin with.

Could you test 2.5.59-base?  Could be that 2.5.59-mm7 is slower for some
reason.

Or it could be that the increased CPU speed now makes the load alternate
between 100% cpu-bound and 100% IO-bound rather than some combination of
both.  (If you understand what I mean by this, please explain it to me some
time).


