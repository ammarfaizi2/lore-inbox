Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUJ3Pb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUJ3Pb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUJ3Paw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:30:52 -0400
Received: from baikonur.stro.at ([213.239.196.228]:50397 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261193AbUJ3PIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:08:24 -0400
Date: Sat, 30 Oct 2004 17:08:10 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Adrian Bunk <bunk@stusta.de>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, kj <kernel-janitors@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] 2.6.10-rc1-kjt1: ixgb_ethtool.c doesn't compile
Message-ID: <20041030150810.GC7330@stro.at>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Nish Aravamudan <nish.aravamudan@gmail.com>,
	kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org
References: <20041024151241.GA1920@stro.at> <20041029235137.GG6677@stusta.de> <29495f1d04102921447ab65101@mail.gmail.com> <20041030050924.GA4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030050924.GA4374@stusta.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Adrian Bunk wrote:

> On Fri, Oct 29, 2004 at 09:44:18PM -0700, Nish Aravamudan wrote:
> > On Sat, 30 Oct 2004 01:51:37 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Sun, Oct 24, 2004 at 05:12:41PM +0200, maximilian attems wrote:
> > > >...
> > > > splitted out 168 patches:
> > > > http://debian.stro.at/kjt/2.6.10-rc1-kjt1/split/
> > > 
> > > Could you provide a .tar.gz (or .tar.bz) of the splitted patches
> > > (similar to how Andrew does for -mm)?
> > 
> > Do you mean like the one he provided?
> > 
> > please test out:
> > http://debian.stro.at/kjt/2.6.10-rc1-kjt1/2.6.10-rc1-kjt1.patch.bz2
> > 
> > Admittedly, it's not tarred first, but still... Maybe you mean
> > something else, though, and I'm just confused.
> >...
> 
> No, I'd like to have a .tar.gz of the split directory, similar to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1-broken-out.tar.gz

thanks for the idea! done for all the older kjt releases. 
you'll find latest:
http://debian.stro.at/kjt/2.6.10-rc1-kjt1/2.6.10-rc1-kjt1-split.tar.bz2
http://debian.stro.at/kjt/2.6.10-rc1-kjt1/2.6.10-rc1-kjt1-split.tar.gz
 
> This way, it would be easier to simply grep for a file causing a 
> problem.

thanks a lot for the testing.

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

