Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTJQOz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJQOz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:55:56 -0400
Received: from usstp09.itcs.purdue.edu ([128.210.5.248]:37011 "EHLO
	usstp09.itcs.purdue.edu") by vger.kernel.org with ESMTP
	id S263487AbTJQOzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:55:54 -0400
Message-ID: <3F9002FA.6030709@purdue.edu>
Date: Fri, 17 Oct 2003 09:55:54 -0500
From: Peter Romba <promba@purdue.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help a newbie:  "make modules_install" causes depmod errors for EVERY
 module on EVERY kernel I try?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I can't compile a kernel anymore.  I recently installed 
gnome 2.4 from source (the only major system change I can think of). 
Now when I try to compile 2.4.21, make modules_install gives depmod 
errors for EVERY module, even dummy.o in the case of an out-of-the-box 
kernel configuration.  This behavior happens on every kernel that I've 
tried.  This is using the typical make mrproper, make menuconfig, make 
dep, make clean, make bzImage, make modules, make modules_install 
sequence of stuff.

In the process of building gnome I had to update ld from an RPM 
(couldn't install it from source, e-mail me if you want details on that).

Any help would be greatly appreciated :)...  I'm at a loss about what to do.

	--Peter
	  promba@purdue.edu

