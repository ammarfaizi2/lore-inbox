Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130971AbRCJJu3>; Sat, 10 Mar 2001 04:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130981AbRCJJuS>; Sat, 10 Mar 2001 04:50:18 -0500
Received: from dyn545.dhcp.lancs.ac.uk ([148.88.245.69]:516 "EHLO
	dyn545.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130971AbRCJJuG>; Sat, 10 Mar 2001 04:50:06 -0500
Date: Fri, 9 Mar 2001 21:26:06 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@localhost.localdomain>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Stephen Torri'" <s.torri@lancaster.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ACPI:system description tables not found.
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE72F@orsmsx35.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0103092123540.10511-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Grover, Andrew wrote:

> download the pmtools package from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm . (It's at the
> bottom.) The acpidmp utility is what you're interested in (you can ignore
> compile errors from the others.) Does this utility find tables, or not?
>
> Thanks -- Regards -- Andy

I got the utility and compiled it under 2.4.2-ac12. No problem wit that.

Acpidump reports:

acpidump: cannot find an RSDP (Is ACPI enabled?).

Yes ACPI is enabled in the system bios. Motherboard is P6DBU (Supermicro)
with Dual P3 @ 450MHz.

Stephen

-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

