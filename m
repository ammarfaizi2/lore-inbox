Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVHYOir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVHYOir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVHYOir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:38:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12708 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750872AbVHYOiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:38:46 -0400
Date: Thu, 25 Aug 2005 15:41:52 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
Message-ID: <20050825144152.GU9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0508251107500.24552@scrub.home> <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk> <20050825135933.GA14448@infradead.org> <Pine.LNX.4.61.0508251610441.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508251610441.3728@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 04:15:39PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 25 Aug 2005, Christoph Hellwig wrote:
> 
> > Yup.  Let's get m68k into buildable shape for 2.6.13 with Al's minimal
> > patches, and if you have further improvements over that submit them as
> > split up patches through the usual channels.  Having all architectures
> > actually build and work from mainline is really important to have
> > useful kernel package in distributions.
> 
> No, there has been no discussion of these patches, so there is no point in 
> doing this a few days before 2.6.13. Can we please do this properly for 
> 2.6.14?
>
> If you want to apply these patches, please also apply the following patch:

OK, fuck that.  Consider the patchbomb withdrawn.
