Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267810AbTBME4I>; Wed, 12 Feb 2003 23:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267958AbTBME4H>; Wed, 12 Feb 2003 23:56:07 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1796
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267810AbTBME4H>; Wed, 12 Feb 2003 23:56:07 -0500
Date: Thu, 13 Feb 2003 00:06:54 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Paul Laufer <paul@laufernet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc)
 - UPDATE
In-Reply-To: <Pine.LNX.4.44.0302121043260.167-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.44.0302130004470.247-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With Adam's new PnP changes, and the disabling of the OS PnP BIOS on the
IBM. I can say that your sb_card.c/h changes (with some small
modifications with the new PnP structure changes) works!

I suppose, this weekend I could see if I can get the AWE itself detected
on 2.5.60 now :-)

Shawn.

