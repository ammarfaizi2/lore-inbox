Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTCEWth>; Wed, 5 Mar 2003 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTCEWtg>; Wed, 5 Mar 2003 17:49:36 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:65165 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S266907AbTCEWtP>; Wed, 5 Mar 2003 17:49:15 -0500
Date: Wed, 5 Mar 2003 22:57:02 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, zwane@linuxpower.ca,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] remove EXPORT_NO_SYMBOLS from amd7xx_tco
Message-ID: <20030305235644.GA23028@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com,
	zwane@linuxpower.ca,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com> <20030305221302.GN20423@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305221302.GN20423@fs.tum.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 11:13:02PM +0100, Adrian Bunk wrote:
 > > Dave Jones <davej@codemonkey.org.uk>:
 > >   o [WATCHDOG] Merge AMD 766/768 TCO Timer/Watchdog driver from 2.4
 > amd7xx_tco.c contains the obsolete EXPORT_NO_SYMBOLS. The following 
 > patch corrects this bug:

Ack, that fix was already in my bk tree at
bk://linux-dj.bkbits.net/watchdog  I guess I forgot to
remind Linus to pull again after taking the first batch of changes.

Linus, pull again, and it should suck it in for next time.

		Dave

