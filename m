Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288404AbSADAEl>; Thu, 3 Jan 2002 19:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288405AbSADAEc>; Thu, 3 Jan 2002 19:04:32 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:59342 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S288404AbSADAE1>; Thu, 3 Jan 2002 19:04:27 -0500
Message-ID: <3C34F1E4.5B0FC1D9@oracle.com>
Date: Fri, 04 Jan 2002 01:05:56 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre6-aeb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andries.brouwer@cwi.nl, torvalds@transmeta.com
Subject: 2.5.2-pre7 still missing bits of kdev_t
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merging Andries' changes for these files gets me a full build:

./fs/reiserfs/inode.c
./fs/reiserfs/super.c
./fs/reiserfs/journal.c
./fs/ext3/super.c
./include/linux/reiserfs_fs.h

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
