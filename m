Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUAFGUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUAFGUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:20:50 -0500
Received: from [66.62.77.7] ([66.62.77.7]:12930 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266075AbUAFGUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:20:50 -0500
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
From: Dax Kelson <dax@gurulabs.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>,
       Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
In-Reply-To: <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
References: <1073354003.4101.11.camel@idefix.homelinux.org>
	 <20040105180859.7e20e87a.akpm@osdl.org>
	 <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1073370806.2687.18.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 23:33:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 19:59, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 05 Jan 2004 18:08:59 PST, Andrew Morton said:
> 
> > Thanks, the acpi-20031203 patch seems to have introduced a handful of
> > regressions.
> 
> As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show_bug.cgi?id=1766
> is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:

Just confirming that the same patched fixed up the battery reporting
problems on my laptop as well.

Dax Kelson
Guru Labs

