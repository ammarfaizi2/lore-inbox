Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUCJQKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUCJQKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:10:47 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51908 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262668AbUCJQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:10:46 -0500
Date: Wed, 10 Mar 2004 11:10:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Richard Browning <richard@redline.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x /
 Crash/Freeze
In-Reply-To: <200403101227.32322.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.58.0403101104290.29087@montezuma.fsmlabs.com>
References: <200403101227.32322.richard@redline.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Richard Browning wrote:

> **** SUMMARY
> Enabling hyperthreading on Asus PCDL Deluxe motherboard w/ 2xP4Xeon causes
> system freeze in short order.
>
> **** DESCRIPTION
> I have an Asus PCDL Deluxe P4Xeon motherboard which has a north/southbridge
> combination allowing system memory to run at 533MHz . The motherboard has the
> usual Asus onboard gigabit ethernet, AD1985 audio, Intel and Promise SATA
> controllers, firewire. All are enabled and operate. I am running dual 2.8GHz
> P4 Xeons.
>
> When hyperthreading is disabled the system is perfectly stable and usable. No
> operating artefacts seem to occur and SMP appears to workcorrectly.
>
> However when hyperthreading is enabled, the system operates for a brief period
> (enough for KDE to boot, for example) before halting. When operating from the
> command line it is usual to see a Machine Check Exception error immediately
> prior to system failure.
>
> **** ENVIRONMENT
> Asus PCDL Deluxe motherboard
> (http://usa.asus.com/products/server/srv-mb/pc-dl/overview.HTM)

Just to make sure, have you tried a bios upgrade?
