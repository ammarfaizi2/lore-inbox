Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHBQt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHBQt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWHBQt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:49:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWHBQtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:49:25 -0400
Date: Wed, 2 Aug 2006 09:49:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc1-mm2 and 2.6.18-rc3 (bttv: NULL pointer derefernce)
Message-Id: <20060802094904.2057eaf4.akpm@osdl.org>
In-Reply-To: <200608021800.23905.dominik.karall@gmx.net>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<200607141830.01858.dominik.karall@gmx.net>
	<200608021800.23905.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 18:00:23 +0200
Dominik Karall <dominik.karall@gmx.net> wrote:

> I'm not sure if anybody is working on this bug (see below), but as it 
> happens with 2.6.18-rc3 too, I think it's important to inform you to 
> avoid that this bug hits the final release.
> 
> thx,
> dominik
> 
> On Friday, 14. July 2006 18:30, Dominik Karall wrote:
> > On Friday, 14. July 2006 07:48, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6
> > >.1 8-rc1/2.6.18-rc1-mm2/
> >
> > Hi,
> > just want to inform you that the bug is present in 2.6.18-rc1-mm2
> > too. But I took a better screenshot which should be readable:
> > http://stud4.tuwien.ac.at/~e0227135/kernel/IMG_5614.JPG

I believe this is fixed in Mauro's not-yet-pulled DVB tree?
