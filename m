Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTBOTAS>; Sat, 15 Feb 2003 14:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTBOTAS>; Sat, 15 Feb 2003 14:00:18 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:23988 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP
	id <S264931AbTBOTAR>; Sat, 15 Feb 2003 14:00:17 -0500
Message-ID: <3E4E8FB8.9080508@verizon.net>
Date: Sat, 15 Feb 2003 14:06:32 -0500
From: Mark K Hannah <m.k.hannah@verizon.net>
Reply-To: m.k.hannah@verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Received following error running "make menuconfig" on 2.4.21pre4-6mdk.

Happened as soon as I picked Sound -> ALSA.

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu71: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1


