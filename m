Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRIUTXz>; Fri, 21 Sep 2001 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274790AbRIUTXo>; Fri, 21 Sep 2001 15:23:44 -0400
Received: from smtp006pub.verizon.net ([206.46.170.185]:5086 "EHLO
	smtp006pub.verizon.net") by vger.kernel.org with ESMTP
	id <S274789AbRIUTXa>; Fri, 21 Sep 2001 15:23:30 -0400
Message-Id: <200109211922.f8LJMhw19705@smtp006pub.verizon.net>
Subject: Re: dumb(?) question about .config file
From: Joe Kellner <res02z2y@gte.net>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: David Hollister <david@digitalaudioresources.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109211347010.2079-100000@terbidium.openservices.net>
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 21 Sep 2001 15:22:39 -0400
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe there should be a config in /boot, there is in mandrake 8.0,
so I assume it's the same.




On 21 Sep 2001 13:47:42 -0400, Ignacio Vazquez-Abrams wrote:
> On Fri, 21 Sep 2001, David Hollister wrote:
> 
> > I have what may be a dumb question, but I can't seem to find a suitable answer.
> >
> > Let's say you install RedHat out of the box.  When you do that, even if you
> > install the kernel source, you don't get a .config file.  Is there some way to
> > create a .config file based on the running kernel?
> >
> > I thought "make oldconfig" would do it, but from what I've read, it doesn't
> > sound like that's necessarily true.
> 
> Install the kernel SRPM and look in the SOURCES directory. They're all there.
> 
> -- 
> Ignacio Vazquez-Abrams  <ignacio@openservices.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

