Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265875AbRGDQRw>; Wed, 4 Jul 2001 12:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265874AbRGDQRl>; Wed, 4 Jul 2001 12:17:41 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:8714 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265875AbRGDQR3>;
	Wed, 4 Jul 2001 12:17:29 -0400
Date: Wed, 4 Jul 2001 12:21:59 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: State of CML2
Message-ID: <20010704122159.A11639@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had kind of fallen out of the habit of posting release announcements here, 
but now that 2.4.6 is out it seems a good time to review the situation.
The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.

The CML2 core is in good shape. There have been no serious bugs since
mid-April.  The latest release (1.6.9) resynchronizes with 2.4.6 and ac24
and adds better compile-time type checking in expressions (thanks to 
Daniel Junglas for getting me off the dime on this).

There are a couple of minor Tkinter weirdnesses remaining in the
xconfig interface, but they don't seem to show up in normal operation
with the Linux kernel rules file.  They are fully described in the
distribution TODO file.

No speed complaints from the beta testers latelyl; the seige of tuning
in May seems to have worked.  The requests I'm getting are pretty much
all for minor UI tweaks.

CML2 has another design win.  The folks at Webmachines now use it to configure
the Linux distribution that they put in the flash ROMS of their network
apppliances.  A lightly edited version of the Webmachines rulesfile is
available on the CML2 project site as an example.

The dungeon walls in CML2 adventure now occasionally feature entertaining
grafitti.  Spot all the in-jokes and collect a valuable no-prize.

CML2 is ready.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A true libertarian supports free enterprise, opposes big business;
supports local self-government, opposes the nation-state; supports the
National Rifle Association, opposes the Pentagon.
	-- Edward Abbey
