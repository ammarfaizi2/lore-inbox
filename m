Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVHDGmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVHDGmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVHDGmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:42:04 -0400
Received: from [194.90.237.34] ([194.90.237.34]:33843 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261854AbVHDGmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:42:02 -0400
Date: Thu, 4 Aug 2005 09:42:23 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
Message-ID: <20050804064223.GT15300@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <20057281331.7vqhiAJ1Yc0um2je@cisco.com> <86802c44050803175873fb0569@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c44050803175873fb0569@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. yhlu <yhlu.kernel@gmail.com>:
> Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
> 
> Roland,
> 
> In LinuxBIOS, If I enable the prefmem64 to use real 64 range. the IB
> driver in Kernel can not be loaded.

Are you using the latest firmware on the HCA card?

-- 
MST
