Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSFKOMU>; Tue, 11 Jun 2002 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSFKOMT>; Tue, 11 Jun 2002 10:12:19 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:24078 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S317058AbSFKOMS>; Tue, 11 Jun 2002 10:12:18 -0400
Date: Wed, 12 Jun 2002 00:14:33 +1000
From: john slee <indigoid@higherplane.net>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: thunder@ngforever.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Futex Asynchronous Interface
Message-ID: <20020611141433.GV27429@higherplane.net>
In-Reply-To: <Pine.LNX.4.44.0206100808180.6159-100000@hawkeye.luckynet.adm> <8QbwcRg1w-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:46:00PM +0200, Kai Henningsen wrote:
> thunder@ngforever.de (Thunder from the hill)  wrote on 10.06.02 in <Pine.LNX.4.44.0206100808180.6159-100000@hawkeye.luckynet.adm>:
> 
> > On Mon, 10 Jun 2002, Helge Hafting wrote:
> > > ls /dev/net
> > > eth0 eth1 eth2 ippp0
> >
> > What is it worth? You have a few more files which you can't do anything
> > with, and ifconfig output is much more greppable etc.
> 
> Ifconfig output is *WHAT*?!
> 
> Ifconfig output, to be parsed by a script, is one of the shittiest  
> interfaces possible.

it may be but you can use 'ip' instead which _is_ much more script
friendly and seems to have at least ifconfig functionality.

j.

-- 
toyota power: http://indigoid.net/
