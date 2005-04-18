Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVDRKRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVDRKRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVDRKRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:17:52 -0400
Received: from mail.dif.dk ([193.138.115.101]:52941 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262018AbVDRKRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:17:50 -0400
Date: Mon, 18 Apr 2005 12:20:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Ehud Shabtai <eshabtai.lkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Need some help to debug a freeze on 2.6.11
In-Reply-To: <Pine.LNX.4.62.0504181215590.2522@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost>
References: <68b6a2bc050418000619a552de@mail.gmail.com>
 <1113818666.357.17.camel@localhost.localdomain>
 <Pine.LNX.4.62.0504181215590.2522@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Jesper Juhl wrote:

> On Mon, 18 Apr 2005, Alexander Nyberg wrote:
> 
> > > I'm running Linux on my laptop and it sometimes freezes (about once a
> > > week). The only thing which seems to work when it's stuck is SysRq (I
> > > can reboot with SysRq+O), however, I'm in X and I don't have a serial
> > > port on my laptop so I can't see any of the outputs of the SysRq
> > > options.
> > > 
> > > After a reboot I don't see anything in my logs about the crash.
> > > 
> > > Can anyone suggest how to get some information about my freeze?
> > 
> > Sounds like a job for Documentation/networking/netconsole.txt
> > 
> or Documentation/serial-console.txt
> 
Console on line printer would also be an option.

-- 
Jesper

