Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVKNVQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVKNVQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVKNVQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:16:07 -0500
Received: from [194.90.237.34] ([194.90.237.34]:23000 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S932137AbVKNVQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:16:03 -0500
Date: Mon, 14 Nov 2005 23:17:56 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114211756.GD3603@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511141556480.4428@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511141556480.4428@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Mon, 14 Nov 2005, Michael S. Tsirkin wrote:
> > 
> > Okay, here's an updated version.
> 
> Looked good to me, but as usual Gleb noticed what I missed.

Yep, I fixed that in an updated patch. Thanks very much Gleb!

> And you
> should be working against 2.6.15-rc1 or 2.6.15-rc1-git, not 2.6.14.
> 
> Hugh
> 

So - its submission time?
I shall go over these 20 missing architectures then :)

-- 
MST
