Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATNEY>; Sat, 20 Jan 2001 08:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRATNEO>; Sat, 20 Jan 2001 08:04:14 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:1796 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129444AbRATNED>; Sat, 20 Jan 2001 08:04:03 -0500
Message-ID: <3A698708.A623EC44@namesys.com>
Date: Sat, 20 Jan 2001 15:39:36 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: edward@namesys.com
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [reiserfs-list] Don't mix reiserfs and RAID5 in linux-2.4.1-pre8, 
 severe corruption
In-Reply-To: <3A68B126.7C5B6262@mail.infotel.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward wrote:
> 
> Reiserfs in linux-2.4.1-pre8 does not properly with the RAID5 code that
> is in that kernel.  It is easy to get corrupted filesystem on device in
> less than 1 minute. Please, do not use it (reiserfs) on RAID5 devices.
> We are trying to figure out what is wrong.
> 
> Edward

There is a report that it is not just reiserfs that has the corruption problem.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
