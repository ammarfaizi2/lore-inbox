Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJLJXQ>; Sat, 12 Oct 2002 05:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262860AbSJLJXQ>; Sat, 12 Oct 2002 05:23:16 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:6017 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262850AbSJLJXP>; Sat, 12 Oct 2002 05:23:15 -0400
Message-Id: <4.3.2.7.2.20021012112824.00b4c1f0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 12 Oct 2002 11:28:52 +0200
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Build fail 2.5.42 modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/intermezzo/vfs.c: In function `presto_debug_fail_blkdev':
fs/intermezzo/vfs.c:134: invalid initializer
fs/intermezzo/vfs.c:136: warning: implicit declaration of function 
`is_read_only'
fs/intermezzo/vfs.c: In function `presto_do_rmdir':
fs/intermezzo/vfs.c:1244: warning: implicit declaration of function 
`double_down'
fs/intermezzo/vfs.c:1260: warning: implicit declaration of function `double_up'
fs/intermezzo/vfs.c: In function `presto_rename_dir':
fs/intermezzo/vfs.c:1627: warning: implicit declaration of function 
`triple_down'
fs/intermezzo/vfs.c:1644: warning: implicit declaration of function `triple_up'
fs/intermezzo/vfs.c: In function `lento_do_rename':
fs/intermezzo/vfs.c:1755: warning: implicit declaration of function 
`double_lock'
fs/intermezzo/vfs.c: In function `lento_iopen':
fs/intermezzo/vfs.c:1934: called object is not a function
fs/intermezzo/vfs.c:1935: parse error before string constant
make[2]: *** [fs/intermezzo/vfs.o] Error 1
make[1]: *** [fs/intermezzo] Error 2
make: *** [fs] Error 2

