Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQKQFqo>; Fri, 17 Nov 2000 00:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQKQFqf>; Fri, 17 Nov 2000 00:46:35 -0500
Received: from rmx325-mta.mail.com ([165.251.48.53]:41695 "EHLO
	rmx325-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129314AbQKQFqS>; Fri, 17 Nov 2000 00:46:18 -0500
Message-ID: <384606296.974438172647.JavaMail.root@web395-wra.mail.com>
Date: Fri, 17 Nov 2000 00:16:09 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre6 ntfs compile error
CC: torvalds@transmeta.com, fdavis112@juno.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.121
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I just try to compile 2.4.0-test11-pre6, and received the following error (make modules):

inode.c:1054 conflicting types for 'new_inode'
/usr/src/liunux/include/linux/fs.h:1153 previous declaration of 'new_inode'

make[2]: ***[inode.o]Error 1
make[2]: Leaving directory '/usr/src/liunux/fs/ntfs'
...
make[1]: *** [modsubdir_ntfs] Error 2

Regards,
Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
