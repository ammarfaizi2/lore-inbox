Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVDTMnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDTMnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVDTMnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:43:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20747 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261597AbVDTMnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:43:06 -0400
Date: Wed, 20 Apr 2005 14:42:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, mlindner@syskonnect.de,
       rroesler@syskonnect.de, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/sk98lin/: possible cleanups
Message-ID: <20050420124257.GK5489@stusta.de>
References: <20050420021526.GB5489@stusta.de> <20050420083928.GA29040@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420083928.GA29040@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 09:39:28AM +0100, Christoph Hellwig wrote:
> On Wed, Apr 20, 2005 at 04:15:26AM +0200, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - make needlessly global functions static
> > - remove unused code
> 
> Not sure it's worth doing much on this, as the driver is beeing
> obsoleted by the skge driver.

I know, but as long as it's in the kernel I'm sending such patches.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

