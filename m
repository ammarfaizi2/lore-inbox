Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSD2QsB>; Mon, 29 Apr 2002 12:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSD2QsA>; Mon, 29 Apr 2002 12:48:00 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:61909 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312790AbSD2Qr7>; Mon, 29 Apr 2002 12:47:59 -0400
Date: Mon, 29 Apr 2002 18:47:12 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Stephan Maciej <stephan@maciej.muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio Laptop problems
Message-ID: <20020429164712.GA12419@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Stephan Maciej <stephan@maciej.muc.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204261728.39745.stephan@maciej.muc.de> <20020429002811.GB3108@arthur.ubicom.tudelft.nl> <200204291630.22969.stephan@maciej.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 04:30:22PM +0200, Stephan Maciej wrote:

> > 1) Update the BIOS, my laptop shipped with an old version and a BIOS
> >    update fixed some keyboard related problems. (you need to boot into
> >    windows for this)
> 
> Can I do this with a DOS bootdisk? I remember that most of the Flash updates 
> require you to startup the computer in a real DOS environment, at least those 
> I have seen for my ASUS P5A and A7V boards.

Unfortunatelly (at least for the C1VM windows XP bios) it 
requires windows installed, so it could launch a fancy graphical
installer, which will test if your laptop is the correct version and 
if it is, it will create the dos boot disk.

Of course it didn't work for me (since I have a C1VE, which is the
european version of the C1VM, and the bios wasn't "certified" for
my version). But I was able to workaround by manually looking at
the temporary files (windows\temp directory) while the fancy setup
utility was running....

Just in case it's useful...

> > 2) Apply the latest ACPI patch.
> 
> I'll try. Is anyone interested in getting positive feedback? You?

Probably the acpi mailing list.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
