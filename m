Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264056AbRFPKGx>; Sat, 16 Jun 2001 06:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264602AbRFPKGo>; Sat, 16 Jun 2001 06:06:44 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:44036 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264056AbRFPKGd>;
	Sat, 16 Jun 2001 06:06:33 -0400
Date: Fri, 15 Jun 2001 15:56:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alex Deucher <adeucher@UU.NET>
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: APM, ACPI, and Wake on LAN - the bane of my existance
Message-ID: <20010615155621.D37@toy.ucw.cz>
In-Reply-To: <3B28F68C.BA9D83DA@uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B28F68C.BA9D83DA@uu.net>; from adeucher@UU.NET on Thu, Jun 14, 2001 at 01:38:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> anything.  So I removed the three pin cross connect that connects the
> card to the WOL header on the motherboard.  That fixed it for a few
> days, but now it's doing it again, even without the cable installed. 
> the only fix is to unplug the ethernet cable when I turn it off.  

So turn it off by unplugging AC cord. If it comes up *without* AC plugged
in.... Welll... Call GhostBusters.
								Pavel
PS: I is possible that machine comes up after powerfail. This might be
your proble. Without 3pin cable installed, it really should not come up
itself.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

