Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDEAHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 20:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDEAHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 20:07:54 -0400
Received: from mail1.coralwave.com ([24.244.175.138]:1031 "EHLO
	mail1.coralwave.com") by vger.kernel.org with ESMTP id S262960AbUDEAHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 20:07:53 -0400
From: Jason Harrison <jharrison@linuxbs.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 blank consoles (tty1-6)
Date: Sun, 4 Apr 2004 20:07:22 -0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404042007.22998.jharrison@linuxbs.dyndns.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Today I upgraded from 2.6.4 to 2.6.5 using my config from 2.6.4.  I have all 
the usual options set for text console such as CONFIG_INPUT=y, CONFIG_VT=y, 
CONFIG_VGA_CONSOLE=y, CONFIG_VT_CONSOLE=y.  However in the 2.6.5 upgrade when 
booting onto this new kernel all my text consoles from tty1-6 are all blank 
after Uniform CD-ROM driver Revision: 3.20.  This is the last thing I see 
before everything goes blank.  The next thing that pops up is the X server.

Any ideas why this is happening?

Thanks for your time and help.

Regards,
Jason Harrison 
