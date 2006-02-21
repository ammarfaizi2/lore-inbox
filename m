Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWBUOgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWBUOgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBUOgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:36:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45060 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932459AbWBUOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:36:41 -0500
Date: Tue, 21 Feb 2006 15:36:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport install_page
Message-ID: <20060221143639.GY4661@stusta.de>
References: <20060220223709.GT4661@stusta.de> <20060221103808.GB19349@infradead.org> <Pine.LNX.4.61.0602211227450.8400@goblin.wat.veritas.com> <20060221141341.GW4661@stusta.de> <1140532473.840.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140532473.840.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:34:33PM +0000, Alan Cox wrote:
> On Maw, 2006-02-21 at 15:13 +0100, Adrian Bunk wrote:
> > This means it has only bloated the kernel for two and a half years 
> > for nearly everyone.
> 
> Wouldn't it be more productive to just shave 30 bytes off some other
> function and make it faster instead of moaning about every single export
> symbol that is provided even when its intentionally part of a complete
> API ?

Wouldn't it be best to do both?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

