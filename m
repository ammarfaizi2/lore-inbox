Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264283AbUEIJbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUEIJbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 05:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbUEIJbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 05:31:48 -0400
Received: from smtp.mailix.net ([216.148.213.132]:5186 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S264283AbUEIJbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 05:31:47 -0400
Date: Sun, 9 May 2004 11:31:39 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Len Brown <len.brown@intel.com>
Cc: Bob Gill <gillb4@telusplanet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20040509093139.GA1377@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Len Brown <len.brown@intel.com>, Bob Gill <gillb4@telusplanet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com> <1084071367.2326.62.camel@dhcppc4>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1084071367.2326.62.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.216.160 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.216.160 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.216.160 listed in dnsbl.sorbs.net]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.216.160 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BMkeq-0001LT-Rn)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown, Sun, May 09, 2004 04:56:07 +0200:
> On Fri, 2004-05-07 at 15:41, Bob Gill wrote:
> > OK, great!  Adding acpi=noirq to the kernel line made the lost
> > interrupt problem go away.
> 
> Bob, Alex,
> (or anybody else with a SIS-961 that now requires acpi=noirq),
> 
> I need some info to find out why your system recently broke.
> 

will do as soon as I get access to the box again. Monday, that is

