Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264007AbRFEPEQ>; Tue, 5 Jun 2001 11:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264008AbRFEPEG>; Tue, 5 Jun 2001 11:04:06 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:39684 "HELO
	gateway.intern.kubla.de") by vger.kernel.org with SMTP
	id <S264007AbRFEPD4>; Tue, 5 Jun 2001 11:03:56 -0400
Date: Tue, 5 Jun 2001 17:03:27 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Pete Zaitcev <zaitcev@redhat.com>, green@linuxhacker.ru,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010605170327.A13375@intern.kubla.de>
In-Reply-To: <mailman.991555081.25242.linux-kernel2news@redhat.com> <200106032051.f53Kpgg10681@devserv.devel.redhat.com> <20010604122708.B33@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010604122708.B33@toy.ucw.cz>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 12:27:11PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > How about ISA USB host controllers?
> > 
> > Those, unfortunately, do not exist. I was shopping for one
> > in vain for a long time. One formiddable difficulty is that
> > USB bandwidth is larger than ISA, so the only feasible way
> > to make a HC is to have all TD's in its onboard memory,
> > as in VGA.
> 
> USB is 1.2MB/sec while 8-bit ISA is 4MB/sec (memory-mapped).
> 
> ...and OHCI does use board memory, anyway.

And strangely enough a couple of vendors offer USB-to-ISA bridges:
passive ISA backplanes that you can connect to your system using
USB.  Just search for "USB ISA" with google.com ...

Dominik
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
