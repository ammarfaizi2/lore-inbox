Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUIQQ70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUIQQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUIQQ70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:59:26 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:52432 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S268933AbUIQQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:50:00 -0400
From: Lei Yang <lya755@ece.northwestern.edu>
To: user-mode-linux-user@lists.sourceforge.net
Subject: Usage of UML (User Mode Linux)
Date: Fri, 17 Sep 2004 11:58:19 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409171158.19098.lya755@ece.northwestern.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear fellows,

I am new to kernel modules and am trying to get a module work right now. I 
need some tools to debug. In order not to risk the host machine, I am 
thinking of using UML. I downloaded the kernel RPM

------user_mode_linux-2.4.19.5um-0.i386.rpm

and root filesystem

------Debian-3.0r0.ext2.bz2

and got Debian boot sucessfully. However, I still have several questions:

1. The kernel version does not match filesystem:
(none):/lib/modules# ls
2.4.18-37um
(none):/lib/modules# uname -r
2.4.19-5um

2. How do I get my own module compiled into the kernel and debug with it?

I've been reading the UML homepage 
http://user-mode-linux.sourceforge.net/index.html 

but have not really found tips helpful to me. Could anyone give me any hint 
how to do this, or where to look at?

TIA!

Lei

