Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDUFOf>; Sat, 21 Apr 2001 01:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRDUFOY>; Sat, 21 Apr 2001 01:14:24 -0400
Received: from ns.hgiga.com ([210.241.239.254]:57359 "HELO hgiga.com")
	by vger.kernel.org with SMTP id <S132395AbRDUFOK>;
	Sat, 21 Apr 2001 01:14:10 -0400
Message-ID: <3AE105A7.78BE590C@hgiga.com>
Date: Sat, 21 Apr 2001 11:59:36 +0800
From: Allen <allen@hgiga.com>
X-Mailer: Mozilla 4.7 [zh_TW] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mec@shout.net
Subject: make menuconfig error
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I use make menuconfig on the /usr/src/linux directory which linux
was symbolic link to /usr/src/linux-2.4.3 , I can see menu , but  when I
press space  or enter key will exit menu and show follow message :

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu11: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
[root@bk linux]#

do you know how to fix it .


