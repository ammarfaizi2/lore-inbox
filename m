Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSKGMEb>; Thu, 7 Nov 2002 07:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbSKGMEb>; Thu, 7 Nov 2002 07:04:31 -0500
Received: from verein.lst.de ([212.34.181.86]:17680 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S266514AbSKGMEa>;
	Thu, 7 Nov 2002 07:04:30 -0500
Date: Thu, 7 Nov 2002 13:10:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add CONFIG_MMU and CONFIG_SWAP
Message-ID: <20021107131058.A7890@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20021103033433.A3383@lst.de> <12569.1036665230@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12569.1036665230@passion.cambridge.redhat.com>; from dwmw2@infradead.org on Thu, Nov 07, 2002 at 10:33:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:33:50AM +0000, David Woodhouse wrote:
> 
> hch@lst.de said:
> >  Now that m68knommu and v850 are merged we need all other
> > architectures to define CONFIG_SWAP and CONFIG_MMU so that we can make
> > code conditional on it. 
> 
> Er, can we have CONFIG_SWAP conditional on other architectures too?

Sure, submit a patch once you tested your particular architecture.

