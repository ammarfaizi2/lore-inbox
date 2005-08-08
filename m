Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVHHMV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVHHMV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVHHMV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:21:28 -0400
Received: from [194.90.237.34] ([194.90.237.34]:62309 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750842AbVHHMV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:21:28 -0400
Date: Mon, 8 Aug 2005 15:21:52 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
Message-ID: <20050808122152.GU15300@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <20057281331.7vqhiAJ1Yc0um2je@cisco.com> <86802c44050803175873fb0569@mail.gmail.com> <20050804064223.GT15300@mellanox.co.il> <86802c4405080411227bce41f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c4405080411227bce41f7@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. yhlu <yhlu.kernel@gmail.com>:
> On 8/3/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> > Quoting yhlu <yhlu.kernel@gmail.com>:
> > > Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
> > >
> > > Roland,
> > >
> > > In LinuxBIOS, If I enable the prefmem64 to use real 64 range. the IB
> > > driver in Kernel can not be loaded.

Could you please test with latest firmware 4.7.0?
Thanks,

-- 
MST
