Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVBQUvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVBQUvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVBQUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:51:04 -0500
Received: from pop.gmx.de ([213.165.64.20]:59520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262071AbVBQUu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:50:56 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger@gmx.at>
To: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 21:58:54 +0100
User-Agent: KMail/1.7.2
Cc: acpi-devel@lists.sourceforge.net,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <200502152038.00401.stefandoesinger@gmx.at> <20050217190815.GC4925@gamma.logic.tuwien.ac.at>
In-Reply-To: <20050217190815.GC4925@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502172158.56721.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 17. Februar 2005 20:08 schrieb Norbert Preining:
> On Die, 15 Feb 2005, Stefan Dösinger wrote:
> > > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> >
> > Do you use the fglrx driver? This doesn't work with any type of suspend
> > so far. If you use the radeon driver try a driver update.
>
> Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
> compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, all
> from http://www.nixnuts.net/files/
>
> But I had no success whatsoever. With this (Xorg server, current dri/drm
> stuff, ..) the laptop not even wakes up from sleep!
Sorry, no Idea. What about 2.6.11-rc3-mm2 + Xorg 6.8.1.99? Did you test this 
combination?
Am I right with assuming that resumeworked after the X upgrade if X wasn't 
started before suspend?

Stefan
