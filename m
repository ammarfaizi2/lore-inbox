Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274097AbRJBNv7>; Tue, 2 Oct 2001 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274079AbRJBNvj>; Tue, 2 Oct 2001 09:51:39 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:1447 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S274041AbRJBNva>;
	Tue, 2 Oct 2001 09:51:30 -0400
Message-ID: <3BB9C65C.E01FCC05@cern.ch>
Date: Tue, 02 Oct 2001 15:51:24 +0200
From: Sylvain Ravot <sylvain.ravot@cern.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make: *** [menuconfig] Error 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have the following error message when I try to compile the 2.4.9
kernel. Could you help me ?

[root@lxusa linux]# make menuconfig

scripts/Menuconfig: line 11:  1872 Segmentation fault      (core dumped)
cat  <<EOM

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

EOM

 Q> scripts/Menuconfig: MCmenu0: command not found
scripts/Menuconfig: line 19:  1874 Segmentation fault      (core dumped)
cat  <<EOM

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

EOM

make: *** [menuconfig] Error 1

Thank in advance for your answer

Sylvain

