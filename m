Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbRBDBJe>; Sat, 3 Feb 2001 20:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131423AbRBDBJY>; Sat, 3 Feb 2001 20:09:24 -0500
Received: from www.inreko.ee ([195.222.18.2]:32464 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131380AbRBDBJN>;
	Sat, 3 Feb 2001 20:09:13 -0500
Date: Sun, 4 Feb 2001 03:19:33 +0200
From: Marko Kreen <marko@l-t.ee>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - HAPPENING NOW!!!
Message-ID: <20010204031933.C23913@l-t.ee>
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net> <20010204031135.B23913@l-t.ee> <3A7CAB00.1E6F9E9D@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A7CAB00.1E6F9E9D@Home.net>; from Shawn.Starr@Home.net on Sat, Feb 03, 2001 at 08:06:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 08:06:08PM -0500, Shawn Starr wrote:
> Wasn't on shutdown though ;-)

The 'shutdown' as in 'process shutdown' ? _Not_ machine
shutdown.

> 
> I was just about to receive a message when things started to lock up slowly.
> Then everything else followed.
> 
> Marko Kreen wrote:
> 
> > On Sat, Feb 03, 2001 at 05:48:36PM -0500, Shawn Starr wrote:
> > > [root@coredump spstarr]# killall -9 gnomeicu
> > >
> > > ... waiting...
> >
> > Could you try it on 2.4.2ac2, I guess its this item:
> >
> > o       Fix datagram hang on shutdown                   (Alexey
> > Kuznetsov)
> >
> > --
> > marko
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
