Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137153AbREKPOW>; Fri, 11 May 2001 11:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137154AbREKPOL>; Fri, 11 May 2001 11:14:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38029 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S137153AbREKPNy>;
	Fri, 11 May 2001 11:13:54 -0400
Message-ID: <3AFC01B1.2D1D9121@mandrakesoft.com>
Date: Fri, 11 May 2001 11:13:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tulip@scyld.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFT: New Tulip ethernet driver update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new development version of the Tulip ethernet driver for 2.4 kernels
has been posted at 
	http://sourceforge.net/projects/tulip/

This version incorporates a number of fixes which I would like to get
tested heavily before incorporating into the kernel.  Update summary is
in tulip.txt in the driver tarball, as well as a more technical
ChangeLog listing all changes.

The driver requires kernel 2.4.3 or later.

Feedback is welcome.  I'm especially interested to know if this driver
fails to work on any -working- 2.4 configurations (it shouldn't). 
Please report bug to the bug tracker on the web page listed above.

Thanks all, and viva la open source!

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
