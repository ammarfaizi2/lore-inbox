Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283087AbRLEHGB>; Wed, 5 Dec 2001 02:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLEHFx>; Wed, 5 Dec 2001 02:05:53 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42231
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283087AbRLEHFg>; Wed, 5 Dec 2001 02:05:36 -0500
Date: Tue, 4 Dec 2001 23:05:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011204230526.G25292@mikef-linux.matchmail.com>
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011201022157.38ed90b5.skraw@ithnet.com> <E169vcF-0000lQ-00@starship.berlin> <20011130155740.I14710@work.bitmover.com> <20011201022157.38ed90b5.skraw@ithnet.com> <20011130210155.B489@mikef-linux.matchmail.com> <8E5ezzRHw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8E5ezzRHw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 12:05:00AM +0200, Kai Henningsen wrote:
> mfedyk@matchmail.com (Mike Fedyk)  wrote on 30.11.01 in <20011130210155.B489@mikef-linux.matchmail.com>:
> 
> > On Sat, Dec 01, 2001 at 02:21:57AM +0100, Stephan von Krawczynski wrote:
> 
> > > So maybe
> > > the real good choice would be this: let the good parts of Solaris (and
> > > maybe its SMP features) migrate into linux.
> >
> > Before 2.3 and 2.4 there probably would've been much more contention against
> > something like this.  Even now with large SMP scalability goals, I think it
> > would be hard to get something like this to be accepted into Linux.
> 
> It works for SGI/Irix/XFS, why would it not work for SUN/Solaris/whatever?
>

I meant actually transplanting Solaris's SMP into Linux.  You don't see SGI
doing anything like this...

