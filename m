Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbWHIJCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbWHIJCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWHIJCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:02:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030544AbWHIJCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:02:23 -0400
Date: Wed, 9 Aug 2006 11:02:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Message-ID: <20060809090208.GB3087@elf.ucw.cz>
References: <20060804162300.GA26148@uio.no> <200608081604.00665.rjw@sisk.pl> <20060808150136.GA16272@uio.no> <200608081741.24099.rjw@sisk.pl> <20060809002159.GE4886@elf.ucw.cz> <20060809084459.GB1368@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809084459.GB1368@uio.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you try with method=powerdown or method=reboot? BIOS black magic
> > is not involved at least in reboot parts...
> 
> I lost you here; I've never heard of these options, nor does Google seem to.
> Do I specify them on the kernel command line, or something else?

echo reboot > /sys/power/disk

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
