Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSI2QMt>; Sun, 29 Sep 2002 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSI2QMt>; Sun, 29 Sep 2002 12:12:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262792AbSI2QMs>;
	Sun, 29 Sep 2002 12:12:48 -0400
Date: Sun, 29 Sep 2002 18:17:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929161722.GA22362@suse.de>
References: <200209290114.15994.jdickens@ameritech.net> <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net> <20020929134620.GD2153@gallifrey> <20020929154254.GD1014@suse.de> <1033316509.13001.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033316509.13001.23.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Alan Cox wrote:
> On Sun, 2002-09-29 at 16:42, Jens Axboe wrote:
> > Has anyone actually sent patches to Linus removing LVM completely from
> > 2.5 and adding the LVM2 device mapper? If I used LVM, I would have done
> > exactly that long ago. Linus, what's your oppinion on this?
> 
> I added LVM2 a while ago for my 2.4-ac tree and haven't looked back, its
> much nicer code and its clean and easy to understand. I wouldnt
> guarantee its bug free but its the kind of code where you can *find* a
> bug if one turns up

As far as I'm concerned that settles it for me. I'll check up on 2.5
lvm2 status tomorrow.

-- 
Jens Axboe

