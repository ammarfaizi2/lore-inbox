Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267347AbUGNKdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267347AbUGNKdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267355AbUGNKdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:33:17 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:56214 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S267347AbUGNKdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:33:14 -0400
Date: Wed, 14 Jul 2004 12:33:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Hermann Gottschalk <hg@ostc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714103311.GA5411@k3.hellgate.ch>
Mail-Followup-To: Hermann Gottschalk <hg@ostc.de>,
	linux-kernel@vger.kernel.org
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl> <20040714080036.GC11178@ostc.de> <20040714090208.GA2274@k3.hellgate.ch> <20040714102849.GD11727@ostc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714102849.GD11727@ostc.de>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 12:28:49 +0200, Hermann Gottschalk wrote:
> > If you set debug in via-rhine to 3, you'll get a more interesting
> > log. Does booting with noacpi help at all?
> 
> I will try noapic.

noapic != noacpi
Both ACPI and APIC have been known to cause problems, though.

Roger
