Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWFGBU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFGBU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFGBU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:20:29 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:28312
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750749AbWFGBU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:20:29 -0400
Subject: Remove patch from 2.6.17-rc5-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: khc@pm.waw.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <1149640272.2633.35.camel@localhost.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
	 <1149622813.11929.3.camel@amdx2.microgate.com>
	 <m3u06yc9mr.fsf@defiant.localdomain>
	 <20060606134816.363cbeca.rdunlap@xenotime.net>
	 <20060606140822.c6f4ef37.rdunlap@xenotime.net>
	 <m3zmgpc3ba.fsf@defiant.localdomain>
	 <20060606160745.2f88ff9c.rdunlap@xenotime.net>
	 <m3ejy1c0uw.fsf@defiant.localdomain>
	 <1149638211.2633.21.camel@localhost.localdomain>
	 <20060606171209.2b21dbb4.rdunlap@xenotime.net>
	 <1149640272.2633.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 20:20:19 -0500
Message-Id: <1149643219.8618.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

The patch fix-kbuild-dependencies-for-synclink-drivers.patch
has proven to be wildly unpopular, so please drop it.

At some point in the 2.6.18 series I will look at an
alternative fix.

Thanks,
Paul


