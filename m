Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSJYNbi>; Fri, 25 Oct 2002 09:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJYNbi>; Fri, 25 Oct 2002 09:31:38 -0400
Received: from news.cistron.nl ([62.216.30.38]:10249 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261405AbSJYNbh>;
	Fri, 25 Oct 2002 09:31:37 -0400
From: Rene Blokland <reneb@orac.aais.org>
Subject: 2.4.43 and cdrecord problems
Date: Fri, 25 Oct 2002 15:37:16 +0200
Organization: Cistron
Message-ID: <slrnarii8b.anj.reneb@orac.aais.org>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1035553036 12199 195.64.94.30 (25 Oct 2002 13:37:16 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.
A plea for help it seems to me kernel related.
I endly want to burn an audio cd and the new version of cdrecord should make
that possible also for Linux users.
I use gcc 3.2 and glibc 2,3 on an AMD K6-3 machine.
But compiling fails with this 1-11a38 version and I realy don't know where to
get any help.
The previous version compiled ok.
This is the error what causes the problems:
	==> COMPILING "OBJ/i586-linux-cc/scsihack.o"
In file included from scsi-linux-sg.c:69,
                 from scsihack.c:127:
/usr/src/linux/include/scsi/scsi.h:172: parse error before "u8"
/usr/src/linux/include/scsi/scsi.h:172: warning: no semicolon at end of struct or union
/usr/src/linux/include/scsi/scsi.h:173: warning: data definition has no type or storage class
make[2]: *** [OBJ/i586-linux-cc/scsihack.o] Error 1
make[2]: Leaving directory `/usr/src/cdrtools-1.11/libscg'
make[1]: *** [all] Error 2

Any help would be very kind, thank you

-- 
Groeten / Regards, Rene J. Blokland

