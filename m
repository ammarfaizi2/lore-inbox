Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSH0RMM>; Tue, 27 Aug 2002 13:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSH0RMM>; Tue, 27 Aug 2002 13:12:12 -0400
Received: from bs1.dnx.de ([213.252.143.130]:6579 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S316615AbSH0RML>;
	Tue, 27 Aug 2002 13:12:11 -0400
Date: Tue, 27 Aug 2002 19:16:22 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Stephen Samuel <samuel@bcgreen.com>
Cc: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: interrupt latency
Message-ID: <20020827171622.GQ6981@pengutronix.de>
References: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FDB@HBMNTX0.da.hbm.com> <3D6B88AE.8010206@bcgreen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3D6B88AE.8010206@bcgreen.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 07:11:58AM -0700, Stephen Samuel wrote:
> http://www.linux.org/dist/index.html contains an index to a number of
> Linux distributions.  Check out the embeded kernels. They include some
> Realtime mods. As an example, RTLinux claims to do hard realtime by
> running the Linux kernel as it's lowest priority task. This is supposed
> to allow serious realtime work without having to mess too much with
> the kernel.

Take also into account that RT-Linux is patented technology (for details
see http://www.aero.polimi.it/~rtai/documentation/articles/moglen.html).

There is also RTAI as an alternative, which has a very supportive user
community. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
