Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRJYM4P>; Thu, 25 Oct 2001 08:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJYM4D>; Thu, 25 Oct 2001 08:56:03 -0400
Received: from f59.law11.hotmail.com ([64.4.17.59]:57866 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273534AbRJYMz7>;
	Thu, 25 Oct 2001 08:55:59 -0400
X-Originating-IP: [193.237.205.20]
From: "Rob MacGregor" <rob_macgregor@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.13 and ACPI not working (HP Omnibook 6000)
Date: Thu, 25 Oct 2001 12:56:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F59K4GB7DEEbRQwGF5u0001425c@hotmail.com>
X-OriginalArrivalTime: 25 Oct 2001 12:56:30.0256 (UTC) FILETIME=[77426300:01C15D54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is an HP Omnibook 6000 laptop, using the provided BIOS.  Kernel 
2.4.13 with ACPI enabled as a module.

On boot, with the debug enabled I get:

tbxface-0107 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:............................................................................................................................................................................................................................................................................................................
300 Control Methods found and parsed (1046 nodes total)
ACPI Namespace successfully loaded at root c02d03c0
ACPI: Core Subsystem version [20010831]
evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8) 
[PCIConfig]
exfldio-0222 [21] Ex_read_field_datum   : Region PCIConfig(2) has no handler
evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8) 
[PCIConfig]
exfldio-0597 [21] Ex_write_field_datum  : **** Region type PCIConfig(2) does 
not have a handler
ACPI: Subsystem enable failed

This is certainly an improvement over previous kernels, however I'd like to 
get it working.  Any thoughts or is this in the hands of those who 
understand such things?

Thanks.

Oh, I'm not on the list, but I will see any replies on the archive.  If you 
want a faster response you'll need to CC me.

--
Rob  |  Please ask questions the smart way:
                http://www.tuxedo.org/~esr/faqs/smart-questions.html

    Please don't CC me on anything sent to mailing lists or send
        me email directly unless it's a privacy issue, thanks.



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

