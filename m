Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUDXPl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDXPl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 11:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUDXPl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 11:41:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48879 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262441AbUDXPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 11:41:25 -0400
Date: Sat, 24 Apr 2004 17:41:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Subject: Re: [2.6 patch] Canonically reference files in Documentation/ code comments part
Message-ID: <20040424154118.GC146@fs.tum.de>
References: <20040423231057.GF24948@fs.tum.de> <20040424095628.B25661@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040424095628.B25661@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 09:56:28AM +0100, Russell King wrote:
> On Sat, Apr 24, 2004 at 01:10:58AM +0200, Adrian Bunk wrote:
> > Below is an updated version of a patch by 
> > Hans Ulrich Niedermann <linux-kernel@n-dimensional.de> to 
> > change all references in comments to files in Documentation/ to start 
> > with Documentation/ .
> 
> I'd prefer to include the 'linux/' part so its obvious that we're
> referring to the kernel tree.  I've given people pointers to files
> in the past, and just giving "Documentation/foo/bar" usually results
> in "I've looked on the web here, there and somewhere else and can't
> find the file."

Arguments in favor of this patch:
- it's more common in the kernel to start the reference at the top
  of the kernel source
- the name of the directory os not linux but linux-<version>

But I don't have a that strong opinion on this issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

