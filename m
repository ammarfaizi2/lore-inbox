Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTKKTVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTKKTVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:21:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14805 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263632AbTKKTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:21:31 -0500
Date: Sat, 1 Nov 2003 08:43:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1 [warning: eats disks with	loop!]
Message-ID: <20031101074312.GR643@openzaurus.ucw.cz>
References: <1067064107.1974.44.camel@laptop-linux> <20031025204940.GB276@elf.ucw.cz> <1067153848.13594.49.camel@laptop-linux> <20031026092551.GB293@elf.ucw.cz> <1067163344.13594.170.camel@laptop-linux> <20031030080430.GB198@elf.ucw.cz> <1067542303.4041.9.camel@laptop-linux> <20031031025849.GA21818@atrey.karlin.mff.cuni.cz> <1067575098.16620.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067575098.16620.4.camel@laptop-linux>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So this was next "for a kernel bug you get one fsck bug
for free" series. I was eventually able to recover it
using alternate superblock; machine now works okay.

				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

