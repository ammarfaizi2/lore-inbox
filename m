Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWAUBCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAUBCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAUBCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:02:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29971 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932285AbWAUBCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:02:30 -0500
Date: Sat, 21 Jan 2006 02:02:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Message-ID: <20060121010229.GP31803@stusta.de>
References: <20060118194103.5c569040.akpm@osdl.org> <200601190543.k0J5hBg06542@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601190543.k0J5hBg06542@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:43:12PM -0800, Chen, Kenneth W wrote:
> Andrew Morton wrote on Wednesday, January 18, 2006 7:41 PM
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> > > 
> > 
> > heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
> > 
> > I doubt if this'll fly.  We're stuck with it.
> 
> 
> Could we please, leave the raw device driver alone.  ISV is doing
> their diligent work converting new code to O_DIRECT, but large amount
> of field customers are still using raw device in their setup.

Why did noone tell me anythong about such issues although I'm the one 
listed as having this driver deprecated?
Is our feature removal process completely busted?

And WTF is ISV?

> - Ken

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

