Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUKWB2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUKWB2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUKWB0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:26:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261202AbUKWBZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:25:13 -0500
Date: Mon, 22 Nov 2004 20:23:33 -0500
From: Dave Jones <davej@redhat.com>
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Message-ID: <20041123012333.GK17249@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
	Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <1101148138.20008.6.camel@d845pe> <20041123004619.GQ19419@stusta.de> <1101172056.20006.153.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101172056.20006.153.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:07:36PM -0500, Len Brown wrote:

 > Laptops have had soft poweroff with APM for a while, but desktops and
 > servers never adopted APM, so soft-power-off is generally a new feature
 > with ACPI for them.

Nonsense.

My 4-way compaq server disagrees with you. No ACPI on that
at all, and it has fully working APM, even in SMP.  Likewise,
I don't think I've ever seen a desktop without APM.
(modulo broken biosen).

IIRC, APM supported this since the arrival of ATX power supplies,
which was a _long_ time ago. 1996/1997 ?

		Dave

