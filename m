Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWHaXMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWHaXMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWHaXMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:12:50 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:34238 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750864AbWHaXMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:12:49 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Thu, 31 Aug 2006 17:13:20 -0600
User-Agent: KMail/1.9.1
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Adam Belay <abelay@novell.com>, "Brown, Len" <len.brown@intel.com>,
       ACPI ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <20060830194317.GA9116@srcf.ucam.org>
In-Reply-To: <20060830194317.GA9116@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311713.21618.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 13:43, Matthew Garrett wrote:
> That would be helpful. For the One Laptop Per Child project (or whatever 
> it's called today), it would be advantageous to run without acpi.

Out of curiosity, what is the motivation for running without acpi?
It costs a lot to diverge from the mainstream in areas like that,
so there must be a big payoff.  But maybe if OLPC depends on acpi
being smarter about power or code size or whatever, those improvements
could be made and everybody would benefit.
