Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbSKDRyO>; Mon, 4 Nov 2002 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSKDRyO>; Mon, 4 Nov 2002 12:54:14 -0500
Received: from [212.104.37.2] ([212.104.37.2]:54797 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S262404AbSKDRyN>; Mon, 4 Nov 2002 12:54:13 -0500
Date: Mon, 4 Nov 2002 19:00:40 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021104180040.GA307@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de> <20021102174727.GA294@dreamland.darkstar.net> <20021102213529.GB3612@suse.de> <20021103145352.GA1083@dreamland.darkstar.net> <20021103150150.GO3612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103150150.GO3612@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Nov 03, 2002 at 04:01:50PM +0100, Jens Axboe ha scritto: 
> > If I don't use hdparm 2.5.42 works. On 2.5.45 it's random.
> 
> 2.5.45 with attached patch, how does that compare?

Ok, I tested you patch. Now I can mount, read, etc. without errors, but
I can still hang the drive usign hdparm -I.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
