Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDNMaE>; Sat, 14 Apr 2001 08:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDNM3z>; Sat, 14 Apr 2001 08:29:55 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7874 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132053AbRDNM3n>;
	Sat, 14 Apr 2001 08:29:43 -0400
Message-ID: <3AD842B3.A4C82698@mandrakesoft.com>
Date: Sat, 14 Apr 2001 08:29:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RealTek 8139 driver updated, tested requested
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of the ethernet driver for RTL-8139-based 10/100 boards
has been posted at

	http://sourceforge.net/projects/gkernel/

This update includes a couple major bugfixes, and I am interested in
getting the widest testing possible for it.

Please report bugs to the bug tracking system on the web page above. 
Please include in your bug report 'lspci -vvv', 'dmesg', and any other
relevant information you can think of.

Thanks,

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
