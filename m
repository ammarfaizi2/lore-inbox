Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWB1O4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWB1O4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWB1O4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:56:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61710 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751110AbWB1O4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:56:43 -0500
Date: Mon, 27 Feb 2006 14:09:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions
Message-ID: <20060227140944.GC2429@ucw.cz>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227061354.GO3674@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-02-06 07:13:54, Adrian Bunk wrote:
> 
> Subject    : S3 sleep hangs the second time - 600X
> References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
> Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
> Handled-By : Luming Yu <luming.yu@intel.com>
> Status     : is being debugged,
>              we might want to change the default back for 2.6.16:
>              http://lkml.org/lkml/2006/2/25/101

Luming's call, but ec_intr apparently fixed some machines, too.s

> Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
> References : http://lkml.org/lkml/2006/2/20/159
> Submitter  : Mark Lord <lkml@rtr.ca>
> Handled-By : Randy Dunlap <rdunlap@xenotime.net>
> Status     : one of Randy's patches seems to fix it

Is this really regression?

-- 
Thanks, Sharp!
