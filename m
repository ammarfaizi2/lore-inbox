Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVCCUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVCCUrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVCCUn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:43:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:3482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262539AbVCCUju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:39:50 -0500
Date: Thu, 3 Mar 2005 12:41:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sean <seanlkml@sympatico.ca>
cc: Jens Axboe <axboe@suse.de>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <4737.10.10.10.24.1109878529.squirrel@linux1>
Message-ID: <Pine.LNX.4.58.0503031239140.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com>   
 <20050302200214.3e4f0015.davem@davemloft.net><42268F93.6060504@pobox.com> 
   <4226969E.5020101@pobox.com><20050302205826.523b9144.davem@davemloft.net>
    <4226C235.1070609@pobox.com><20050303080459.GA29235@kroah.com>   
 <4226CA7E.4090905@pobox.com><Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
    <20050303165533.GQ28536@shell0.pdx.osdl.net><20050303170336.GL19505@suse.de>
    <Pine.LNX.4.58.0503030952120.25732@ppc970.osdl.org>
 <4737.10.10.10.24.1109878529.squirrel@linux1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Sean wrote:
> 
> Wait a second though, this tree will be branched from the development
> mainline.   So it will contain many patches that entered with less
> testing.

Well, since I'd pull basically all the time, all the patches _do_ get 
testing the the -rc kernels. 

But the rules would be that small patches can also be verified 
independently.

And realize that the 2.6.x tree doesn't "change" any way. It doesn't get 
more unruly just because we have a side tree that is being anal about 
things. It's still as stable as it ever is..

		Linus
