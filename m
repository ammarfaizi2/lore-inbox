Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262565AbTCISUz>; Sun, 9 Mar 2003 13:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262566AbTCISUz>; Sun, 9 Mar 2003 13:20:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262565AbTCISUz>;
	Sun, 9 Mar 2003 13:20:55 -0500
Date: Sun, 9 Mar 2003 12:07:08 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "Tomasz Torcz, BG" <zdzichu@irc.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
In-Reply-To: <14500000.1047231917@[10.10.2.4]>
Message-ID: <Pine.LNX.4.33.0303091205280.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Martin J. Bligh wrote:

> Look for akpm's latest -mm tree release notes - the patch is embedded
> in there.

Actually, sysfs is officially fscked in 2.5.64. I'm looking into it, so 
more reports of it crashing are not necessary. :) I apologize for the 
inconveniences this has caused.

	-pat

