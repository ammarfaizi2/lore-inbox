Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTG1Ne6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269451AbTG1Ne6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:34:58 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:32530 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269423AbTG1Ne5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:34:57 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PM] Make yenta work
Date: Mon, 28 Jul 2003 21:48:59 +0800
User-Agent: KMail/1.5.2
Cc: Russell King <rmk@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282148.59950.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russel has a patch pending which saves the (128) PCI registers as well. This is needed on my hardware for example

Regards
Michael


-- 
Powered by linux-2.6-test1-mm1. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, keyboard failure with
		        ACPI, PCI IRQ sharing and swsusp
2.6 kernel testing: PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3. 

More info on swsusp: http://sourceforge.net/projects/swsusp/

