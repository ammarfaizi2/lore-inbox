Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129167AbRCBONv>; Fri, 2 Mar 2001 09:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRCBONl>; Fri, 2 Mar 2001 09:13:41 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:15659 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S129167AbRCBON1>;
	Fri, 2 Mar 2001 09:13:27 -0500
Message-ID: <3A9FAA74.792F35C@vz.cit.alcatel.fr>
Date: Fri, 02 Mar 2001 15:13:09 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: cooker <cooker@linux-mandrake.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kernel-source-2.4.2-4mdk.i586.rpm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using menuconfig:

/bin/sh scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions, parsing.scripts/Menuconfig: ./MCmenu0: line 88: syntax error near unexpected token `fi'
scripts/Menuconfig: ./MCmenu0: line 88: `fi'
.............................................................scripts/Menuconfig: ./MCmenu64: line 15: syntax error near unexpected token `}'
scripts/Menuconfig: ./MCmenu64: line 15: `}'
...done.
[H[2J
Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu0: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

So, I used Xconfig. no problem.

