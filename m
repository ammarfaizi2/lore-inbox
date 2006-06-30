Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWF3Qhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWF3Qhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWF3Qhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:37:33 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:4570 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750767AbWF3Qhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:37:32 -0400
Date: Fri, 30 Jun 2006 19:31:08 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, Roland Dreier <rdreier@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 0 of 39] ipath - bug fixes, performance enhancements,and portability improvements
Message-ID: <20060630163108.GA24882@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1151617251@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 30 Jun 2006 16:35:54.0359 (UTC) FILETIME=[41A3D870:01C69C63]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> Subject: [PATCH 0 of 39] ipath - bug fixes, performance enhancements,and portability improvements
> 
> Hi, Andrew -
> 
> These patches bring the ipath driver up to date with a number of bug fixes,
> performance improvements, and better PowerPC support.  There are a few
> whitespace and formatting patches in the series, but they're all self-
> contained.  The patches have been tested internally, and shouldn't contain
> anything controversial.
> 
> My hope is that they'll sit in -mm for a little bit, and make it into
> an early 2.6.18 -rc kernel.

OK, next week I'll put these into my tree, too.
Bryan, as far as I can see there were some comments with regard to patches 38
and 39 in the series. Will you be sending updated revisions of these?

-- 
MST
