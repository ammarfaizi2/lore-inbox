Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUKWFBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUKWFBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUKWEtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:49:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262330AbUKWDrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 22:47:14 -0500
Date: Mon, 22 Nov 2004 22:45:18 -0500
From: Dave Jones <davej@redhat.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Message-ID: <20041123034518.GP17249@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
	Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net> <1101178052.20007.196.camel@d845pe> <20041123025004.GM17249@redhat.com> <200411222213.21168.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411222213.21168.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:13:21PM -0500, Gene Heskett wrote:

 > A link to a neat util was posted earlier today, to 'gcccpuopt', which 
 > scans things and reports the appropriate options to put in the 
 > Makefile.  But it doesn't even contain the 'powernow' string.  Does 
 > this need updated?

Very likely not. What would you expect it to do ?

		Dave

