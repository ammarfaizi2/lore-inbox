Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266504AbSKGK1M>; Thu, 7 Nov 2002 05:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266505AbSKGK1M>; Thu, 7 Nov 2002 05:27:12 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:14581 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266504AbSKGK1L>; Thu, 7 Nov 2002 05:27:11 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021103033433.A3383@lst.de> 
References: <20021103033433.A3383@lst.de> 
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add CONFIG_MMU and CONFIG_SWAP 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 10:33:50 +0000
Message-ID: <12569.1036665230@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hch@lst.de said:
>  Now that m68knommu and v850 are merged we need all other
> architectures to define CONFIG_SWAP and CONFIG_MMU so that we can make
> code conditional on it. 

Er, can we have CONFIG_SWAP conditional on other architectures too?

--
dwmw2


