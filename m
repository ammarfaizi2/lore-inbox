Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbTFWE1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 00:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbTFWE1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 00:27:34 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:29743 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S265940AbTFWE1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 00:27:33 -0400
Message-ID: <3EF53379.7030700@mail.gatech.edu>
Date: Sun, 22 Jun 2003 00:41:29 -0400
From: Roland Krystian Alberciak <gtg142g@mail.gatech.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: linux-2.4.21-0.18mdk alsa problem in make menuconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there's a problem configuring alsa with menuconfig, which the 
.log file of changes through mandrake RPM install fails to account:
 
 Upon being in make menuconfig, editing the alsa configuration, one 
happens upon this error. Please note, the changelog for this .18 kernel 
reports alsa issues have been resolved... are you also getting this same 
error?
 
---

 Menuconfig has encountered a possible error in one of the kernel's
 configuration files and is unable to continue. Here is the error
 report:
 
 Q> scripts/Menuconfig: line 832: MCmenu73: command not found
 
 Please report this to the maintainer <mec@shout.net>. You may also
 send a problem report to <linux-kernel@vger.kernel.org>.
 
 Please indicate the kernel version you are trying to configure and
 which menu you were trying to enter when this error occurred.
 
 make: *** [menuconfig] Error 1




Please review:
http://www.linuxquestions.org/questions/showthread.php?s=&postid=347175#post347175

For my thread on this topic.

