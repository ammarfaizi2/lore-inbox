Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264773AbSJVRDq>; Tue, 22 Oct 2002 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264775AbSJVRDq>; Tue, 22 Oct 2002 13:03:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:20155 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264773AbSJVRDp>;
	Tue, 22 Oct 2002 13:03:45 -0400
Message-ID: <3DB5865B.4462537F@digeo.com>
Date: Tue, 22 Oct 2002 10:09:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <m17kgbuo0i.fsf@frodo.biederman.org> <Pine.LNX.4.44L.0210221221460.25116-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 17:09:47.0804 (UTC) FILETIME=[D33DADC0:01C279ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> ...
> In short, we really really want shared page tables.

Or large pages.  I confess to being a little perplexed as to
why we're pursuing both.
