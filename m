Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRHFWiY>; Mon, 6 Aug 2001 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269082AbRHFWiP>; Mon, 6 Aug 2001 18:38:15 -0400
Received: from moline.gci.com ([205.140.80.106]:9993 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S269081AbRHFWiA>;
	Mon, 6 Aug 2001 18:38:00 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E14A4@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: tegeran@home.com, Nico Schottelius <nicos@pcsystems.de>,
        safemode <safemode@speakeasy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 3c509: broken(verified)
Date: Mon, 6 Aug 2001 14:38:04 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight [:tegeran@home.com] writes:
> On Monday 06 August 2001 08:54 am, Nico Schottelius wrote:
> > > i was just using a 3c509 in my friend's old 486 and it was working
> > > fine with 2.4.7.   Just modprobed it and set up the ips and it was
> > > able to ping and be pinged.
> >
> [snip]
> You mention the problem is being unable to change the media, I was 
> unaware this was even possible with the current 3c509 driver, 
> and most people do it on 3c509's and other PNP cards of this sort 
> (such as NE2000 clones)  by using a DOS boot diskette and the DOS
> utilities provided by the manufacturer.


Either that or they head over to Donald Becker's site and
and get the configuration/diagnostic utilities that run under unix.
	http://www.scyld.com/page/support/network/

I've only had one board that was supported by the drivers that
needed to be "DOS util'd" first.  Most everything else that I have
work right out of the box, or after tweaking with his utilities.
