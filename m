Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132967AbRASTAm>; Fri, 19 Jan 2001 14:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132367AbRASTAM>; Fri, 19 Jan 2001 14:00:12 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:16021 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132382AbRASTAB>; Fri, 19 Jan 2001 14:00:01 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: edward@namesys.com, Edward <edward@mail.infotel.ru>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Don't mix reiserfs and RAID5 in linux-2.4.1-pre8, severe corruption
Date: Fri, 19 Jan 2001 13:59:45 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Neil Brown <neilb@cse.unsw.edu.au>
In-Reply-To: <3A68B126.7C5B6262@mail.infotel.ru>
In-Reply-To: <3A68B126.7C5B6262@mail.infotel.ru>
MIME-Version: 1.0
Message-Id: <01011913594500.20418@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is not  just a reiserfs/raid problem.  Corruption has been reported on 
the kernel mailing list with software raid 5 and ext2...

Ed

On Friday 19 January 2001 16:27, Edward wrote:
> Reiserfs in linux-2.4.1-pre8 does not properly with the RAID5 code that
> is in that kernel.  It is easy to get corrupted filesystem on device in
> less than 1 minute. Please, do not use it (reiserfs) on RAID5 devices.
> We are trying to figure out what is wrong.
>
> Edward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
