Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSKUF4v>; Thu, 21 Nov 2002 00:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSKUF4v>; Thu, 21 Nov 2002 00:56:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:1968 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264004AbSKUF4u>;
	Thu, 21 Nov 2002 00:56:50 -0500
Message-ID: <3DDC7746.200ACDE2@digeo.com>
Date: Wed, 20 Nov 2002 22:03:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manish Lachwani <manish@Zambeel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 SMP hangs ..
References: <233C89823A37714D95B1A891DE3BCE5202AB1975@xch-a.win.zambeel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 06:03:51.0301 (UTC) FILETIME=[C3B3AB50:01C29123]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Lachwani wrote:
> 
> I am seeing system hangs with 2.4.17 SMP kernel when doing mke2fs accros 12
> drives in parallel. However, the hangs only occur when the I/O rate from
> vmstat is high:
> 

Quite possibly it has not hung.  You just need to wait half an
hour or so.

The algorithm isn't very good.
