Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbTIJVWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTIJVWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:22:15 -0400
Received: from lidskialf.net ([62.3.233.115]:7132 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265765AbTIJVWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:22:06 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: Pavel Machek <pavel@ucw.cz>, Claas Langbehn <claas@rootdir.de>
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Date: Wed, 10 Sep 2003 22:20:31 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20030910103142.GA1053@rootdir.de> <20030910154702.GB1507@rootdir.de> <20030910171139.GB2764@elf.ucw.cz>
In-Reply-To: <20030910171139.GB2764@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309102220.31806.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Sep 2003 6:11 pm, Pavel Machek wrote:
> Hi!
>
> > > > APIC error on CPU0: 08(08)
> > > >
> > > > ...and it repeats endlessly :(
> > > >
> > > > my keyboard is dead afterwards.
> > >
> > > Can you test on -test3 kernel?
> >
> > Ok, I will later today.
> >
> >
> > BTW: when I suspend from X11 with the nvidia-drivers, then
> > the screen looks even worse :(
>
> Nvidia is binary only, right? I can't help with that.

Unless he's using the opensource nv drivers that come with X?


