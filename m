Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVACXUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVACXUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVACXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:20:39 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:13509 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261944AbVACXUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:20:20 -0500
Date: Tue, 4 Jan 2005 01:20:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [2.6 patch] infiniband: possible cleanups
Message-ID: <20050103232011.GB7747@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050103171937.GG2980@stusta.de> <52sm5i70um.fsf@topspin.com> <20050103231024.GP2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103231024.GP2980@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Adrian Bunk (bunk@stusta.de) "[openib-general] Re: [2.6 patch] infiniband: possible cleanups":
> On Mon, Jan 03, 2005 at 11:45:53AM -0800, Roland Dreier wrote:
> > Thanks, I've applied the changes adding "static" to our tree.  I'm
> > holding off on the "#if 0" changes since some is code useful for
> > debugging modules and other code is used by modules in development.
> 
> Is there an ETA when the debugging modules and the modules in 
> development will be merged into the kernel?
> 
> > Thanks,
> >   Roland
> 
> cu
> Adrian

I saw some bits in Linus bk tree, if thats what you mean by "the kernel".

mst
