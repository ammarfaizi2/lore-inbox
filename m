Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272803AbTHEOBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272802AbTHEOBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:01:35 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:3300 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272803AbTHEOBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:01:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16175.47282.627835.2678@gargle.gargle.HOWL>
Date: Tue, 5 Aug 2003 16:01:22 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, heine@instmath.rwth-aachen.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
In-Reply-To: <20030805134823.GD16091@fs.tum.de>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se>
	<20030805130324.GC16091@fs.tum.de>
	<16175.45710.993756.301205@gargle.gargle.HOWL>
	<20030805134823.GD16091@fs.tum.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > On Tue, Aug 05, 2003 at 03:35:10PM +0200, Mikael Pettersson wrote:
 > > 
 > > ftape-4.04? That's been a non-integrated external package for ages and ages.
 > > I doubt there's been any updates in it for 2.5/2.6 kernels.
 > >...
 > 
 > Is there a good reason why it wasn't / isn't integrated?

Claus-Justus (the official maintainer) never bothered doing it.

 > > Given how few still use these antiques (my "fast" Conner/Seagate drive gives
 > > 150KBps backup speed, wow!) I think simply maintaining status quo is the most
 > > reasonable use of peoples' time.
 > 
 > The problem is that 2.6 doesn't maintain the status quo - it's no longer 
 > possible to use ftape on a SMP workstation.

Yes, but fixing that one problem is probably a lot less work than merging ftape-4.
