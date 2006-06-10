Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWFJSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWFJSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWFJSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:43:25 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:1684 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030501AbWFJSnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:43:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: 2.6.16-rc6-mm2
Date: Sat, 10 Jun 2006 20:43:40 +0200
User-Agent: KMail/1.9.3
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <6bffcb0e0606100925s2577fb25he22bd4ee086a6234@mail.gmail.com> <200606101942.48968.dominik.karall@gmx.net>
In-Reply-To: <200606101942.48968.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606102043.40123.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 June 2006 19:42, Dominik Karall wrote:
> On Saturday, 10. June 2006 18:25, Michal Piotrowski wrote:
> > On 10/06/06, Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Saturday, 10. June 2006 06:40, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> > > >.6.1 7-rc6/2.6.17-rc6-mm2/
> > >
> > > Hi Andrew!
> > >
> > > 2.6.17-rc6-mm2 and -mm1 don't boot on my amd64 machine. When I
> > > select the kernel in grub my computer reboots.
> > >
> > > config, cpuinfo and lspci can be found at:
> > > http://stud4.tuwien.ac.at/~e0227135/kernel/
> >
> > Please try to disable SMP and PREEMPT.
> 
> Thanks! 2.6.17-rc6-mm2 boots fine withouth SMP and PREEMPT.
s/rc6/rc7/

FYI, on my AMD64 box it works just fine with PREEMPT (still without SMP).

Greetings,
Rafael
