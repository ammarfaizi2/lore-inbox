Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbSJIKYH>; Wed, 9 Oct 2002 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJIKYH>; Wed, 9 Oct 2002 06:24:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261562AbSJIKYF>;
	Wed, 9 Oct 2002 06:24:05 -0400
Date: Wed, 9 Oct 2002 12:29:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: mdew <mdew@mdew.dyndns.org>, Cameron Bahar <CBahar@s8.com>,
       "'jfs-discussion@www-124.ibm.com'" 
	<jfs-discussion@www-124.southbury.usf.ibm.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: [Jfs-discussion] maximum filesystem size limit
Message-ID: <20021009102914.GA620@suse.de>
References: <8D587D949A61D411AFE300D0B74D75D703F0BF1B@server.s8.com> <200210091153.59452.roy@karlsbakk.net> <1034158761.5865.1.camel@mdew> <200210091225.24185.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091225.24185.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09 2002, Roy Sigurd Karlsbakk wrote:
> > > > Can someone please tell me if I can use JFS to create a single 12TB
> > > > filesystem under Linux?
> > >
> > > Afaik, you have a problem here concerning the Linux 2.4 maximum block
> > > device size of 2TB.
> >
> > is this "fixed" in 2.5 yet?
> 
> I beleive so

why reply if you are only guessing?

status of 2.5 64-bit sector_t patches looks promising, will likely end
up on 2.5 soonish.

-- 
Jens Axboe

