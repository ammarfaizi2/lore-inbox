Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWILS1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWILS1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWILS1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:27:31 -0400
Received: from rs27.luxsci.com ([66.216.127.24]:23455 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S1030341AbWILS1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:27:30 -0400
Message-ID: <4506FC27.70507@firmworks.com>
Date: Tue, 12 Sep 2006 08:27:51 -1000
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: jg@laptop.org
CC: Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
       ACPI ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI: Idle Processor PM Improvements
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>	<20060830194317.GA9116@srcf.ucam.org>	<200608311713.21618.bjorn.helgaas@hp.com>	<1157070616.7974.232.camel@localhost.localdomain>	<20060904130933.GC6279@ucw.cz>	<1157466710.6011.262.camel@localhost.localdomain>	<20060906103725.GA4987@atrey.karlin.mff.cuni.cz>	<20060906145849.GE2623@cosmic.amd.com>	<20060912092100.GC19482@elf.ucw.cz> <1158084871.28991.489.camel@localhost.localdomain>
In-Reply-To: <1158084871.28991.489.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gettys wrote:
>
>  I haven't checked if there are any write-only
> registers in the Geode (though, thankfully, this kind of brain damage is
> rarer than it once was). 
I've been going through the Geode and 5536 specs with a fine-toothed 
comb, and so far haven't seen any write-only registers apart from the 
ones in the ISA legacy devices.

