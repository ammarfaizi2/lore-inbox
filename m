Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWA2XgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWA2XgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWA2XgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:36:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28677 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932080AbWA2XgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:36:22 -0500
Date: Mon, 30 Jan 2006 00:36:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129233621.GB3777@stusta.de>
References: <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de> <20060129131815.GB21386@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060129131815.GB21386@hardeman.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:18:15PM +0100, David Härdeman wrote:
>...
> you still haven't answered 
> the question of how signed modules and/or binaries can be implemented
> in userspace...
>...

It seems I'm slowly getting the point.

I was partially confused by your backup daemon deamon example that can 
be equally well implemented in userspace.

Signed modules and/or binaries seems to be the application this might be 
required for, so let's discuss exactly this application and not the 
others.

> Re,
> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

