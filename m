Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUHZPPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUHZPPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUHZPPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:15:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52724 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269028AbUHZPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:15:37 -0400
Date: Thu, 26 Aug 2004 17:15:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Olivier Galibert <galibert@pobox.com>,
       Christoph Hellwig <hch@infradead.org>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826151529.GF29965@fs.tum.de>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk> <200408261245.47734.christian.mayrhuber@gmx.net> <20040826115229.A18013@infradead.org> <20040826124334.GA39176@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826124334.GA39176@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:43:34PM +0200, Olivier Galibert wrote:
> On Thu, Aug 26, 2004 at 11:52:29AM +0100, Christoph Hellwig wrote:
> > Sure, no one stops you from playing around with new semantics.  But please
> > don't add them to the linux kernel stable series until we have semantics we
> > a) want to stick to for a while and b) actually work.
> 
> He's not proposing to add it to 2.4, is he?

2.6 is a stable series...

>   OG.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

