Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSKXVxh>; Sun, 24 Nov 2002 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSKXVxg>; Sun, 24 Nov 2002 16:53:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:32004 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261723AbSKXVxg>;
	Sun, 24 Nov 2002 16:53:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211242211.gAOMBSUU000706@darkstar.example.net>
Subject: Re: 2.4.20-rc3 keyboard & mouse lost in X
To: murrayr@brain.org (Murray J. Root)
Date: Sun, 24 Nov 2002 22:11:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021124214007.GB1597@Master.Wizards> from "Murray J. Root" at Nov 24, 2002 04:40:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I've mentioned it before many times, (since 2.4.20-pre8) so I'll just
> > > mention - it still happens.
> > > Going to X mouse and keyboard stop responding.
> > > 
> > > Not a good thing, since most users like using X.
> > 
> > Are you sure it isn't an XF86Config problem?  Does 2.4.19 work?
> 
> 2.4.19 works - every 2.4.x works up to 2.4.20pre8. pre8 with ac3
> works (what I'm using now). If you look back you'll see I've reported
> this for many versions (most of 2.5.4x has the same problem).

Try disabling the local APIC, if it is enabled.

> The ONLY difference between working and not working is the kernel
> version.

2.4.x and 2.5.x have very different input layers, so it is suprising
that the same problem is occuring with both trees.

John.
