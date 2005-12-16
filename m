Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVLPWmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVLPWmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVLPWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:42:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62726 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932540AbVLPWmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:42:51 -0500
Date: Fri, 16 Dec 2005 23:42:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6 patch] drivers/pci/: possible cleanups
Message-ID: <20051216224246.GL23349@stusta.de>
References: <20050218235419.GE4337@stusta.de> <20050219145047.GB455@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219145047.GB455@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 02:50:47PM +0000, Matthew Wilcox wrote:
> On Sat, Feb 19, 2005 at 12:54:19AM +0100, Adrian Bunk wrote:
> > - remove the following unused functions:
> >   - pci.c: pci_find_ext_capability
> 
> The pcie bridge driver ought to be using this.  I haven't submitted that
> cleanup patch yet.

Any news regarding your cleanup patch?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

