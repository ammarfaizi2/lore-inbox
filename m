Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWHKXnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWHKXnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWHKXnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:43:11 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:35718 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751250AbWHKXnJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:43:09 -0400
Date: Sat, 12 Aug 2006 01:42:46 +0200
From: fork0@t-online.de (Alex Riesen)
To: Nicholas Miell <nmiell@comcast.net>
Cc: Jeff Garzik <jeff@garzik.org>, keith.packard@intel.com,
       Linux-kernel@vger.kernel.org, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
Subject: Re: Announcing free software graphics drivers for Intel i965 chipset
Message-ID: <20060811234246.GA16586@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Nicholas Miell <nmiell@comcast.net>, Jeff Garzik <jeff@garzik.org>,
	keith.packard@intel.com, Linux-kernel@vger.kernel.org,
	Dirk Hohndel <dirk.hohndel@intel.com>,
	Imad Sousou <imad.sousou@intel.com>
References: <1155151903.11104.112.camel@neko.keithp.com> <44DACD51.7080607@garzik.org> <1155190917.2349.4.camel@entropy> <81b0412b0608110705y75cd5307vf73dd0b6ee107f81@mail.gmail.com> <1155321063.2522.1.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155321063.2522.1.camel@entropy>
User-Agent: Mutt/1.5.11
X-ID: Gz21M2ZLweCh9RZvlr+jQG1lS1PbNAymYG0IhErfEFbWHX8GtFYh4K
X-TOI-MSGID: b4408055-e469-41a7-8db4-4307a34c3485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell, Fri, Aug 11, 2006 20:31:03 +0200:
> > >
> > > More importantly, where's the source to intel_hal.so?
> > >
> > 
> > ...and what'd break if the call to intel_hal_set_content_protection is
> > omited?
> 
> Where's that call at?
> 

In XOrg parts, I believe. I don't have that tarbal handy, and there is no
traces of that symbol anywhere on the driver's pages (not even in git repos)
anymore.

> All I saw were intel_hal_wm_pass and intel_hal_recalculate_urb_fence in
> Mesa, both of which appear to be strictly optimizations.

still not very nice.

