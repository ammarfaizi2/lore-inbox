Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBYDjc>; Mon, 24 Feb 2003 22:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTBYDjc>; Mon, 24 Feb 2003 22:39:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:455 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266981AbTBYDjb>; Mon, 24 Feb 2003 22:39:31 -0500
Date: Mon, 24 Feb 2003 19:49:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <10580000.1046144972@[10.10.2.4]>
In-Reply-To: <3E5AD2BA.1010608@namesys.com>
References: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmast
 er.ca> <3E5AD2BA.1010608@namesys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I expect to have 16-32 CPUs in my $3000 desktop in 5 years .  If you all
> start planning for that now, you might get it debugged before it happens
> to me.;-)

Thank you ... some sanity amongst the crowd

> I don't expect to connect the 16-32 CPUs with ethernet.... but it won't
> surprise me if they have non-uniform memory.

Indeed. Just look at AMD hammer for NUMA effects, and SMT and multiple
chip on die technologies for the way things are going.

M.


