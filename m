Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbTCWJBU>; Sun, 23 Mar 2003 04:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262984AbTCWJBU>; Sun, 23 Mar 2003 04:01:20 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:52615 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262983AbTCWJBT>; Sun, 23 Mar 2003 04:01:19 -0500
Date: Sun, 23 Mar 2003 10:01:52 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] Sensors chip w83781d for linux-2.5.6[45] (follow up on PCI quirk for SMBus bridge on Asus P4 boards)
Message-ID: <20030323090152.GA1113@brodo.de>
References: <20030319211837.GA23651@brodo.de> <1048146514.12350.43.camel@workshop.saharact.lan> <20030320084148.GA2414@brodo.de> <20030322131503.254c2aa7.azarah@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322131503.254c2aa7.azarah@gentoo.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 01:15:03PM +0200, Martin Schlemmer wrote:
> Hi
> 
> After I had this P4T533-C's SMBus enabled again on 2.5 kernel with
> Dominik's patch, I thought it will be a good time to try and get
> lm_sensors to work again.
> 
> I did not have much luck with a CVS snapshot of lm_sensors2 though,
> so I hacked 2.5.64bk12 to include the w83781d module.  Yes, it is
> rather hackish, but it seems to work just fine.

works fine over here, AFAICT. thanks!

	Dominik
