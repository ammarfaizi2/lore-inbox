Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUGFTBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUGFTBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGFTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:01:53 -0400
Received: from ulysses.noc.ntua.gr ([147.102.222.230]:35089 "EHLO
	ulysses.noc.ntua.gr") by vger.kernel.org with ESMTP id S264276AbUGFTBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:01:52 -0400
From: Kefalas Apostolos <akef@freemail.gr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: compiling 2.6.7
Date: Tue, 6 Jul 2004 21:23:09 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407062123.09586.akef@freemail.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am compiling kernel 2.6.5 and i get the following errors:

drivers/pcmcia/i82365.c: In function `is_alive':
drivers/pcmcia/i82365.c:672: warning: `check_region' is deprecated (declared 
at include/linux/ioport.h:121)
drivers/pcmcia/i82365.c: In function `isa_probe':
drivers/pcmcia/i82365.c:806: warning: `check_region' is deprecated (declared 
at include/linux/ioport.h:121)
drivers/pcmcia/i82365.c: In function `i365_set_io_map':
drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
limited range of data type
drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
limited range of data type

