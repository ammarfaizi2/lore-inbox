Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSEISrt>; Thu, 9 May 2002 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEISrs>; Thu, 9 May 2002 14:47:48 -0400
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:32392 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S314095AbSEISrq>; Thu, 9 May 2002 14:47:46 -0400
Date: Thu, 9 May 2002 14:47:02 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow.websense.net
Reply-To: William Stearns <wstearns@pobox.com>
To: Andi Kleen <ak@muc.de>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH & call for help: Marking ISA only drivers 
In-Reply-To: <20020509203719.A3746@averell>
Message-ID: <Pine.LNX.4.44.0205091445570.2626-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening, Andi,

On Thu, 9 May 2002, Andi Kleen wrote:

> This patch tries to make most ISA only drivers dependent on CONFIG_ISA. 

	I did quite a bit of this work for CML2 - bus dependencies can be 
found in the CML2 sources.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Do you smell something burning or is it me?"
        -- Joan of Arc
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                        http://www.stearns.org
--------------------------------------------------------------------------

