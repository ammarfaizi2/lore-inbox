Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293516AbSCASuC>; Fri, 1 Mar 2002 13:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293507AbSCAStw>; Fri, 1 Mar 2002 13:49:52 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:30935 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S293516AbSCAStl>; Fri, 1 Mar 2002 13:49:41 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7C9F@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Marcin Gogolewski'" <marcing@ms-itti.com.pl>,
        linux-kernel@vger.kernel.org
Cc: "Mike Smith (E-mail)" <msmith@freebsd.org>
Subject: RE: Oops with ACPI (in sched:566)
Date: Fri, 1 Mar 2002 10:49:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marcin Gogolewski [mailto:marcing@ms-itti.com.pl]
> I have STL2 machine, if I compile kernel (2.4.18) with ACPI I got:
> [...] (I hope this is OK, I write it down from monitor ;-) )
> ACPI: Core Subsystem version [20011018]
> Scheduling in interrupt
> kernel BUG at sched:566!

I've heard of problems with STL2 before, due to a poor ACPI BIOS.

If you're willing, I'd be great if you could get the ACPI pmtools
(http://developer.intel.com/technology/iapc/acpi/downloads.htm), run
acpidmp, and send me the output. At least then I can put the STL2 on the
ACPI blacklist, and maybe we can figure out more about the problem, too.

Regards -- Andy
