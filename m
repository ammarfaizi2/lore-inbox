Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290776AbSARTGF>; Fri, 18 Jan 2002 14:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290668AbSARTF4>; Fri, 18 Jan 2002 14:05:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5901 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290633AbSARTFj>;
	Fri, 18 Jan 2002 14:05:39 -0500
Date: Fri, 18 Jan 2002 20:05:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020118200523.F27835@suse.de>
In-Reply-To: <5.1.0.14.2.20020118021222.04e4caa0@pop.cus.cam.ac.uk> <Pine.LNX.4.40.0201180928500.934-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201180928500.934-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18 2002, Davide Libenzi wrote:
> On Fri, 18 Jan 2002, Anton Altaparmakov wrote:
> 
> > Since the new IDE core from Andre is now solid as reported by various
> > people on IRC, here is my local patch (stable for me) which you can apply
> > to play with the shiny new IDE core (IDE core fix is same as
> > ata-253p1-2.bz2 from Jens). (-:
> 
> I would like to say the same. I worked with the fixed kernel
> 2.5.3-pre1+ata-253p1-2 yesterday w/out problems. I rebootedt the machine
> before leaving the office yesterday night and this morning it had a full
> screen :
> 
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt

What mode? PIO and no multi mode, or?

-- 
Jens Axboe

