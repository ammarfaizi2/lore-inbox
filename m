Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274808AbRIUUGT>; Fri, 21 Sep 2001 16:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274809AbRIUUGJ>; Fri, 21 Sep 2001 16:06:09 -0400
Received: from gate.web2010.com ([216.157.79.250]:64978 "EHLO
	archimedes.garrettm.com") by vger.kernel.org with ESMTP
	id <S274807AbRIUUFy>; Fri, 21 Sep 2001 16:05:54 -0400
Message-Id: <200109212005.f8LK5xI02428@archimedes.garrettm.com>
Content-Type: text/plain; charset=US-ASCII
From: Garrett Marone <garrett@garrettm.com>
Reply-To: garrett@garrettm.com
To: linux-kernel@vger.kernel.org
Subject: Re: dumb(?) question about .config file
Date: Fri, 21 Sep 2001 16:05:58 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200109211922.f8LJMhw19705@smtp006pub.verizon.net>
In-Reply-To: <200109211922.f8LJMhw19705@smtp006pub.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in /usr/src/linux there is a configs directory that has files with names of 
kernel configurations, simply whatever matches what you want, or are running 
to /usr/src/linux/.config and run make oldconfig

Garrett - garrett@garrettm.com

On Friday 21 September 2001 03:22 pm, Joe Kellner wrote:
> I believe there should be a config in /boot, there is in mandrake 8.0,
> so I assume it's the same.
>
> On 21 Sep 2001 13:47:42 -0400, Ignacio Vazquez-Abrams wrote:
> > On Fri, 21 Sep 2001, David Hollister wrote:
> > > I have what may be a dumb question, but I can't seem to find a suitable
> > > answer.
> > >
> > > Let's say you install RedHat out of the box.  When you do that, even if
> > > you install the kernel source, you don't get a .config file.  Is there
> > > some way to create a .config file based on the running kernel?
> > >
> > > I thought "make oldconfig" would do it, but from what I've read, it
> > > doesn't sound like that's necessarily true.
> >
> > Install the kernel SRPM and look in the SOURCES directory. They're all
> > there.
> >
> > --
> > Ignacio Vazquez-Abrams  <ignacio@openservices.net>
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
