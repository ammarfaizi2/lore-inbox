Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129240AbRCHR1z>; Thu, 8 Mar 2001 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRCHR1f>; Thu, 8 Mar 2001 12:27:35 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:11732 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129240AbRCHR11>; Thu, 8 Mar 2001 12:27:27 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE72F@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Stephen Torri'" <s.torri@lancaster.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ACPI:system description tables not found.
Date: Thu, 8 Mar 2001 09:26:22 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Torri [mailto:s.torri@lancaster.ac.uk]

> I am using kernel-2.4.2-ac12 (will try ac14). The motherboard is a
> Supermicro P6DBU. (I will need to check the board when I get home to
> confirm). I get the messages below when the system starts:
> 
> acpi: system description tables not found
> 
> The manufacturer says that there is support for acpi. So I 
> willing to beat
> it around a bit to get the tables found. Any ideas where to start?

download the pmtools package from
http://developer.intel.com/technology/iapc/acpi/downloads.htm . (It's at the
bottom.) The acpidmp utility is what you're interested in (you can ignore
compile errors from the others.) Does this utility find tables, or not?

Thanks -- Regards -- Andy

