Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSIOG4w>; Sun, 15 Sep 2002 02:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSIOG4w>; Sun, 15 Sep 2002 02:56:52 -0400
Received: from packet.digeo.com ([12.110.80.53]:22406 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317887AbSIOG4w>;
	Sun, 15 Sep 2002 02:56:52 -0400
Message-ID: <3D84340A.25ED4C69@digeo.com>
Date: Sun, 15 Sep 2002 00:17:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] add vmalloc stats to meminfo
References: <3D8422BB.5070104@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 07:01:40.0315 (UTC) FILETIME=[BDB7F2B0:01C25C85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Some workloads like to eat up a lot of vmalloc space.

Which workloads are those?

>  It is often hard to tell
> whether this is because the area is too small, or just too fragmented.  This
> makes it easy to determine.

I do not recall ever having seen any bug/problem reports which this patch
would have helped to solve.  Could you explain in more detai why is it useful?
