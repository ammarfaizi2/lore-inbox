Return-Path: <linux-kernel-owner+w=401wt.eu-S1753612AbWLPSzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbWLPSzA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbWLPSy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:54:59 -0500
Received: from mail.enyo.de ([212.9.189.167]:4324 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbWLPSy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:54:59 -0500
X-Greylist: delayed 1411 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 13:54:59 EST
From: Florian Weimer <fw@deneb.enyo.de>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
Date: Sat, 16 Dec 2006 19:31:25 +0100
In-Reply-To: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> (Marc Haber's
	message of "Thu, 7 Dec 2006 16:57:40 +0100")
Message-ID: <87hcvv66bm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Haber:

> After updating to 2.6.19, Debian's apt control file
> /var/cache/apt/pkgcache.bin corrupts pretty frequently - like in under
> six hours.

I've seen that with Debian's 2.6.18 kernels as well.  Perhaps it's
related to this Debian bug?

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=401006>
