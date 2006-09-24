Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWIXVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWIXVFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIXVFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:05:49 -0400
Received: from mail.rucls.net ([65.126.99.146]:26843 "EHLO mail.rucls.net")
	by vger.kernel.org with ESMTP id S932100AbWIXVFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:05:48 -0400
Date: Sun, 24 Sep 2006 16:05:47 -0500
From: Mark Felder <felderado@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel@vger.kernel.org, hancockr@shaw.ca
Subject: Re: Bug: Asus CUR-DLS and 2.6
Message-Id: <20060924160547.e9764600.felderado@gmail.com>
In-Reply-To: <200609242153.14245.linux@rainbow-software.org>
References: <fa.oxv6SpXdmGM3attVfc3DVbNIcEk@ifi.uio.no>
	<4516D8DF.4060402@shaw.ca>
	<20060924143240.48bf330e.felderado@gmail.com>
	<200609242153.14245.linux@rainbow-software.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 21:53:13 +0200
Ondrej Zary <linux@rainbow-software.org> wrote:

> On Sunday 24 September 2006 21:32, you wrote:
> > On Sun, 24 Sep 2006 13:13:35 -0600
> >
> > Robert Hancock <hancockr@shaw.ca> wrote:
> > > Mark Felder wrote:
> > > > With a 2.6.15 and 2.6.16 kernel on Gentoo I would receive 3 beeps and
> > > > it would hardlock as I expained. The CPU fans shut off -- there's no
> > > > hope of bringing it out of this. Rarely it's happened at GRUB or before
> > > > GRUB, but only when I've been working on this for a long period of
> > > > time.
> > >
> 
> 3 beeps and fans turning off - looks like APM suspend mode to me.
> 
> 
> -- 
> Ondrej Zary
> 


That's an interesting suspicion, but I just checked all of my kernel configs for every kernel that I've compiled and subsequently had this issue. They all have CONFIG_APM is not set.



Mark
