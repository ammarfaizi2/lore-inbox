Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUAYWl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUAYWl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:41:58 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:27554 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S265325AbUAYWl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:41:57 -0500
Message-ID: <40144617.7040901@verizon.net>
Date: Sun, 25 Jan 2004 22:41:27 +0000
From: Mark K Hannah <mk.hannah@verizon.net>
Reply-To: mk.hannah@verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Menuconfig Error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [138.88.227.206] at Sun, 25 Jan 2004 16:41:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following error received while trying to get into "Advanced Linux Sound 
Arch."  Crashes as soon as you select.

Also getting module compile errors...I assume it is because I can't get 
into ALSA parameters to shut off usbaudio under ALSA.

Using Mandrake 9.2 and kernel-source-2.4.22-10mdk
Mark Hannah


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu78: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
