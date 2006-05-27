Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWE0BRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWE0BRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWE0BRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:17:40 -0400
Received: from outgoing-mail.its.caltech.edu ([131.215.239.19]:19293 "EHLO
	outgoing-mail.its.caltech.edu") by vger.kernel.org with ESMTP
	id S964884AbWE0BRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:17:40 -0400
Date: Fri, 26 May 2006 18:12:44 -0700 (PDT)
From: johanson@caltech.edu
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: kernel compilation error
Message-ID: <Pine.LNX.4.64.0605261806410.25767@arctic.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Scanned: at Caltech-ITS on earth-dog by amavisd-2.3.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cat /etc/issue
Red Hat Enterprise Linux AS release 3 (Taroon Update 7)

kernel kernel-2.4.21-40.EL

In menuconfig:

Network Device Support->Ethernet (1000 Mbit)

  menucofig did not present the 1000 mbit device 
page but immediately exited with the following error:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

  Q> scripts/Menuconfig: line 832: MCmenu36: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.


Ernie Johanson
Information Security
California Institute of Technology
johanson@caltech.edu
http://www.imss.caltech.edu/
