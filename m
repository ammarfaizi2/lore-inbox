Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTLEXLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbTLEXLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:11:20 -0500
Received: from legolas.restena.lu ([158.64.1.34]:4021 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264601AbTLEXLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:11:07 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031205225554.GT29119@mis-mike-wstn.matchmail.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
	 <20031205225554.GT29119@mis-mike-wstn.matchmail.com>
Content-Type: text/plain
Message-Id: <1070665864.3962.19.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 00:11:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-05 at 23:55, Mike Fedyk wrote:
> On Fri, Dec 05, 2003 at 11:11:39AM -0800, Allen Martin wrote:
> > NVIDIA doesn't provide a windows driver to setup APIC interrupts.  APIC
> > functionality is exported through the ACPI methods and MP table in the
> > system BIOS which the motherboard vendors supply.
> > 
> > Likely the root of the problem has to do with the way the Linux kernel is
> > using the ACPI methods to setup the interrupts which is different from win
> > 9x/2k/XP.  I can help track this down, unfortunately so far I've been unable
> > to reproduce the hangs on any of the boards I have.
> 
> Can the people with nforce chips run a command that will show the chipset
> config space like was done back when there were problems with via chipsets
> (before via released the specs on how to set the bits correctly).
> 
> Maybe you'll see some correlation between the boards that are crashing, and
> a few bits that are different for the boards that aren't crashing.
> -

Is there such a command? or is that your question? Ready to run it as
soon as someone lets me know.

Craig
Uptime: 6.5 hours

