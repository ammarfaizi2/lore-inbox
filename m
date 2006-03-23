Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWCWKMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCWKMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 05:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWKMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 05:12:25 -0500
Received: from [194.90.237.34] ([194.90.237.34]:64670 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750990AbWCWKMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 05:12:24 -0500
Date: Thu, 23 Mar 2006 12:13:15 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060323101315.GE1802@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com> <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com> <20060323064113.GC9841@mellanox.co.il> <1143103701.6411.21.camel@camp4.serpentine.com> <20060323093713.GB1802@mellanox.co.il> <1143107463.6411.54.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143107463.6411.54.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 23 Mar 2006 10:15:08.0437 (UTC) FILETIME=[A9838C50:01C64E62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> > I understand they do, but they could just use the parts of IB stack and
> > never notice.
> 
> No, in some cases they want there to not be an IB stack present, which
> is not the same thing at all as not caring if it's there.

OK. I gather that much. But why? I'm just trying to figure out the motivation.
Might this be interesting for our drivers too?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
