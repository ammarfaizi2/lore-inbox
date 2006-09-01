Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIANPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIANPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWIANPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:15:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:62616 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751096AbWIANPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:15:04 -0400
X-Authenticated: #31060655
Message-ID: <44F83247.8050309@gmx.net>
Date: Fri, 01 Sep 2006 15:14:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060728 SUSE/1.0.4-2.1 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: jg@laptop.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM	Improvements
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>	<200608311713.21618.bjorn.helgaas@hp.com>	<1157070616.7974.232.camel@localhost.localdomain> <200608312353.05337.len.brown@intel.com>
In-Reply-To: <200608312353.05337.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> 
> But frankly, with gaping functionality holes in Linux suspend/resume support such as
> IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
> is somewhat "forward looking".

OLPC has no IDE/SATA devices, just 512 MB of onboard NAND flash.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
