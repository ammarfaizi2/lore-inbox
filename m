Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSKCOsC>; Sun, 3 Nov 2002 09:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSKCOsC>; Sun, 3 Nov 2002 09:48:02 -0500
Received: from [212.104.37.2] ([212.104.37.2]:62474 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261996AbSKCOsA>; Sun, 3 Nov 2002 09:48:00 -0500
Date: Sun, 3 Nov 2002 15:53:52 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021103145352.GA1083@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de> <20021102174727.GA294@dreamland.darkstar.net> <20021102213529.GB3612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102213529.GB3612@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Nov 02, 2002 at 10:35:29PM +0100, Jens Axboe ha scritto: 
> On Sat, Nov 02 2002, Kronos wrote:
> > Il Sat, Nov 02, 2002 at 04:27:25PM +0100, Jens Axboe ha scritto: 
> > > > I can't even mount a cd using my CDRW drive (CD-ROM drive is ok).
> > > 
> > > Does 2.5.42 work?
> > 
> > I can reproduce it using hdparm -i /dev/hdd:

[cut]
 
> What is this, 2.5.42 or 2.5.45?

Both.

> Does 2.5.42 work or not? 

If I don't use hdparm 2.5.42 works. On 2.5.45 it's random.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.
