Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSFXOzw>; Mon, 24 Jun 2002 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSFXOzw>; Mon, 24 Jun 2002 10:55:52 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:7041 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313767AbSFXOzu>;
	Mon, 24 Jun 2002 10:55:50 -0400
Date: Sat, 22 Jun 2002 20:42:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020622184220.GD105@elf.ucw.cz>
References: <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net> <3D125735.7000805@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D125735.7000805@evision-ventures.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> That's called /. BTW. If anything I'm missing there is the
> representation of the very first BUS out there: CPU!!!

And if you have four cpus, two of them having southbridge with PCI?
You might make cpu%d the root....
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
