Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVGZJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVGZJW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGZJW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 05:22:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7441 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261663AbVGZJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 05:22:26 -0400
Date: Tue, 26 Jul 2005 11:22:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Al Boldi <a1426z@gawab.com>
Cc: "'Horst von Brand'" <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: kernel optimization
Message-ID: <20050726092215.GJ3160@stusta.de>
References: <200507231849.j6NInMPO003728@laptop11.inf.utfsm.cl> <200507260524.IAA06931@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507260524.IAA06931@raad.intranet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 08:22:59AM +0300, Al Boldi wrote:
> Dr. Horst H. von Brand wrote: {
> Al Boldi <a1426z@gawab.com> wrote:
> >  Adrian Bunk wrote: {
> > On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:
> > > i would like to ask if it possible to change the optimization of the 
> > > kernel from -O2 to -O3 :D, how can i do that? if i change it to the 
> > > top level Makefile does it change to all the Makefiles?
> > And since it's larger, it's also slower.
> > }
> 
> > It's faster but it's flawed.  Root-NFS boot failed!
> 
> How do you know that it is faster if it is busted?
> }
> 
> The -O3 compile produces a faster kernel, which seems to work perfectly,
> albeit the Root-NFS boot flaw!

How did you measure that you that your -O3 kernel isn't slower?

> Al

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

