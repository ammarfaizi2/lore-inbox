Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUIBKh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUIBKh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUIBKh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:37:26 -0400
Received: from ozlabs.org ([203.10.76.45]:46735 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268165AbUIBKgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:36:32 -0400
Date: Thu, 2 Sep 2004 20:32:45 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc64] update pSeries_defconfig
Message-ID: <20040902103245.GX26072@krispykreme>
References: <20040902095035.GW26072@krispykreme> <20040902111634.A22852@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902111634.A22852@infradead.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> BTW, g5_defconfig also needs an update :)

Yep :) Id also like to see arch/ppc64/defconfig be something that boots 
on both g5 and pseries.

Anton
