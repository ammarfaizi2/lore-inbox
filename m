Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDHVMy (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTDHVMx (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:12:53 -0400
Received: from blue.net4u.hr ([193.110.68.3]:15575 "HELO blue.net4u.hr")
	by vger.kernel.org with SMTP id S261807AbTDHVMw (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:12:52 -0400
Message-ID: <3E931AF2.3020905@dmska.org>
Date: Tue, 08 Apr 2003 20:54:42 +0200
From: Armando Vega <synan@dmska.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: error report
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was the error:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu71: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

I compiled linux-2.4.21-0.13mdk kernel..
However, the kde version of linuxconfig worked flawlessly, while i tried 
"mneuconfig" a couple of times and when trying to access "Linux Advanced 
Sound Architecture" it gave this error..

Hope i could help..
=)

