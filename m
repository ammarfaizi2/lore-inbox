Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVGXPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVGXPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGXPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 11:15:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:57024 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261382AbVGXPOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 11:14:35 -0400
Date: Sun, 24 Jul 2005 17:14:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: "Amit S. Kale" <amitkale@linsyssoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
In-Reply-To: <20050724142352.GB1778@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0507241713210.11580@yvahk01.tjqt.qr>
References: <200507231130.07208.amitkale@linsyssoft.com> <20050724142352.GB1778@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Maybe you want to put your development machines on ext*2* while doing
>this ;-). Or perhaps reiserfs/xfs/something.

Or perhaps into at the VFS level, so any fs can benefit from it.



Jan Engelhardt
-- 
