Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUJGAe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUJGAe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbUJGAe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:34:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269561AbUJGAeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:34:17 -0400
Date: Thu, 7 Oct 2004 01:34:14 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, ak@muc.de, jgarzik@pobox.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [ink@jurassic.park.msu.ru: Re: [PATCH] Sort generic PCI fixups after specific ones]
Message-ID: <20041007003414.GJ16153@parcelfarce.linux.theplanet.co.uk>
References: <20041006201311.GG16153@parcelfarce.linux.theplanet.co.uk> <20041006170228.1f8e5efd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006170228.1f8e5efd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 05:02:28PM -0700, Andrew Morton wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > Greg asked me to resend this patch and cc l-k, so here it is.
> 
> Does this make
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/sort-generic-pci-fixups-after-specific-ones.patch
> obsolete, or what?

Yes.  Ivan thinks there are cases that
sort-generic-pci-fixups-after-specific-ones.patch won't fix, and I
don't care enough to argue.  His patch fixes my problem, so let's go
with it instead.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
