Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTDKAe5 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTDKAe5 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:34:57 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:42605 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id S264277AbTDKAez (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 20:34:55 -0400
To: cj_chitwood@bellsouth.net
Cc: mec@shout.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Possible problem report, MDK 9.1 kernel config script
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030410002147.62fa9449.cj_chitwood@bellsouth.net> (cj_chitwood@bellsouth.net's
 message of "Thu, 10 Apr 2003 00:21:47 -0400")
References: <20030410002147.62fa9449.cj_chitwood@bellsouth.net>
Date: Fri, 11 Apr 2003 02:46:31 +0200
Message-ID: <86n0ix274o.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "cj" == cj chitwood <cj_chitwood@bellsouth.net> writes:

cj> Good day.
cj> I was going through the menus for kernel configuration, and received an error.  The error was received when I tried to enter "Advanced Linux Sound Architecture" submenu from the sound support menu.  I was dropped to my terminal, and the following output was on my screen:

cj> ################ BEGIN QUOTE ################

cj> Menuconfig has encountered a possible error in one of the kernel's configuration files and is unable to continue.  Here is the error report:

Q> scripts/Menuconfig: line 832: MCmenu71: command not found

cj> Please report this to the maintainer <mex@shout.net>.  You may also send a problem report to <linux-kernel@vger.kernel.org>.

cj> Please indicate the kernel version you are trying to configure and which menu you were trying to enter when this error occurred.

cj> make: *** [menuconfig] Error 1
cj> [root@ip-two linux]# _

Please, update to a cooker kernel 2.4.21-0.14 or 0.15mdk cooker
kernel.  This problem is fixed.

In the future, send reports about Mandrake kernels to mandrake lists
(kernel@mandrakesoft.com or cooker@mandrakesoft.com).

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
