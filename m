Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUA3WDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUA3WDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:03:10 -0500
Received: from lakemtao02.cox.net ([68.1.17.243]:49373 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S264356AbUA3WDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:03:01 -0500
From: "Eric Von York Sr." <yorkfamily@ieee.org>
To: linux-kernel@vger.kernel.org
Subject: menuconfig error 
Date: Fri, 30 Jan 2004 17:04:41 -0500
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401301704.41570.yorkfamily@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

encountered the following error while trying to customize 2.4.22-10mdk on
Mandrake Linux 9.2 . I was in the sound module, and when I clicked on the 
alsa sub-menu it barfed - and always does at this point. 


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu78: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

