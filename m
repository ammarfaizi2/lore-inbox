Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135645AbRDSMQP>; Thu, 19 Apr 2001 08:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135646AbRDSMQF>; Thu, 19 Apr 2001 08:16:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16390 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135645AbRDSMPq>;
	Thu, 19 Apr 2001 08:15:46 -0400
Date: Thu, 19 Apr 2001 14:15:38 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Message-ID: <20010419141538.S16822@suse.de>
In-Reply-To: <01041714250400.01376@antares> <01041913393800.01240@antares> <20010419134601.P16822@suse.de> <01041914131100.01232@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041914131100.01232@antares>; from s-jaschke@t-online.de on Thu, Apr 19, 2001 at 02:13:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Stefan Jaschke wrote:
> > > I applied your patch to 2.4.4-pre4. It compiled fine, but crashed during
> > > boot (just right after the IDE init) with
> >
> > This should fix it.
> 
> It boots now. But I still cannot read a DVD-RAM disk (same behavior 
> as before):

This is really strange, are you sure your drive is ok? Does mounting
dvd-rom and cd-rom's work fine?

-- 
Jens Axboe

