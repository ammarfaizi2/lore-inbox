Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTFLOgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTFLOgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:36:32 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:54695 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264831AbTFLOgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:36:31 -0400
Date: Thu, 12 Jun 2003 15:50:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Gregor Essers <gregor.essers@web.de>
Cc: I Am Falling I Am Fading <skuld@anime.net>, linux-kernel@vger.kernel.org
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <20030612145001.GA14647@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Gregor Essers <gregor.essers@web.de>,
	I Am Falling I Am Fading <skuld@anime.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306120512320.13378-100000@inconnu.isu.edu> <000f01c33013$c713eeb0$6602a8c0@Schleppi> <000c01c3301c$017e0740$6602a8c0@Schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c01c3301c$017e0740$6602a8c0@Schleppi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 03:18:51PM +0200, Gregor Essers wrote:
 > here i have a tip for Slackware Users with ATI Cards (9700pro).
 > 
 > http://www.n3t.net/Infos/Slackware-ATI-Radeon9700Pro.shtml

That's nice, the latest ATI driver contains 98% of the KT400 AGP
driver I wrote for 2.5. The remainder being 1% copyright/credit
notices that they didn't need, and the other 1% being some breakage
to make sure it can't possibly work in AGP 3 mode.

What a train wreck.

I would look deeper into the source, but I'd rather not take a second
look at my lunch right now.

Go ATI!

		Dave

