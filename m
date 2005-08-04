Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVHDSWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVHDSWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVHDSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:22:07 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:17853 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261487AbVHDSWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:22:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T28396teWkprqZJHtrH8jGVTCdqYVKDvJrL5bZCOstegZKIs6WLseXvdwuPu/pSli8oICcRFYjtoRcoCMGLdLsnH5sgHuwTL2GYOly34O01P91sky44M8UX8RXWVvQgfqstH1MKY5O3kbaff08U8DHAgH7L99WkZ8cGMgEmejbY=
Message-ID: <86802c4405080411227bce41f7@mail.gmail.com>
Date: Thu, 4 Aug 2005 11:22:05 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20050804064223.GT15300@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	 <86802c44050803175873fb0569@mail.gmail.com>
	 <20050804064223.GT15300@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.

On 8/3/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> Quoting r. yhlu <yhlu.kernel@gmail.com>:
> > Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
> >
> > Roland,
> >
> > In LinuxBIOS, If I enable the prefmem64 to use real 64 range. the IB
> > driver in Kernel can not be loaded.
> 
> Are you using the latest firmware on the HCA card?
> 
> --
> MST
>
