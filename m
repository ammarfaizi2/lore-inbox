Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSKFQvJ>; Wed, 6 Nov 2002 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265823AbSKFQvI>; Wed, 6 Nov 2002 11:51:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:34749 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265816AbSKFQvI>;
	Wed, 6 Nov 2002 11:51:08 -0500
Message-ID: <3DC94A01.1ADC918E@digeo.com>
Date: Wed, 06 Nov 2002 08:57:37 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, netdev@oss.sgi.com
Subject: Re: 2.5.46-mm1 3 uninitialized timers during boot, ipv6 related?
References: <3DC8D423.DAD2BF1A@digeo.com> <3DC9192E.62600E21@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 16:57:38.0413 (UTC) FILETIME=[9CAFB1D0:01C285B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> I see these aren't dangerous, but I guess they're there for
> someone to see.  So here they are.
> Seems they have something to do with ipv6.
> 

Dave has a bunch of additional fixes for net/*.  Expect them to emerge
from kernel.org real soon.
