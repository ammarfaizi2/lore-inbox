Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUCQSup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCQSup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:50:45 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:57011 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261946AbUCQSun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:50:43 -0500
Date: Wed, 17 Mar 2004 19:50:41 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>
Cc: thomas.schlichter@web.de, phil.el@wanadoo.fr, schwab@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <20040317102550.2ca7737c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.55.0403171946550.14525@jurand.ds.pg.gda.pl>
References: <200403090014.03282.thomas.schlichter@web.de>
 <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
 <200403091208.20556.thomas.schlichter@web.de> <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
 <20040317102550.2ca7737c.akpm@osdl.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Andrew Morton wrote:

> I still have a couple of NMI patches in -mm:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi_watchdog-local-apic-fix.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi-1-hz.patch
> 
> What should we do with these?

 I think we should ask Mikael Pettersson as he is the local APIC watchdog 
expert.  Mikael?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
