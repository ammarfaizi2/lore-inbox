Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTIEXCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTIEXCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:02:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:63158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262577AbTIEXCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:02:30 -0400
Date: Fri, 5 Sep 2003 15:56:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, adq_dvb@lidskialf.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI
 fixed)
Message-Id: <20030905155658.43cc3b6f.rddunlap@osdl.org>
In-Reply-To: <20030905152805.521281b6.akpm@osdl.org>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	<3F59018E.5060604@pobox.com>
	<200309060016.16545.adq_dvb@lidskialf.net>
	<3F590E28.6090101@pobox.com>
	<20030905152805.521281b6.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003 15:28:05 -0700 Andrew Morton <akpm@osdl.org> wrote:

| Jeff Garzik <jgarzik@pobox.com> wrote:
| >
| > Many of us have patch-applying scripts,
| 
| But only one of us documented them ;)
| 
| 	http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.12/

Neil Brown documented his somewhat.  His 'wiggle' is the best
thing about his package IMO.
<http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/>

Having used both of them as well as some of my own, I prefer
a mix of Andrew's and my own...

--
~Randy
