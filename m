Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGSxO>; Wed, 7 Feb 2001 13:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGSwy>; Wed, 7 Feb 2001 13:52:54 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:42699 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129032AbRBGSwn>;
	Wed, 7 Feb 2001 13:52:43 -0500
Message-ID: <3A81996C.3060600@lycosmail.com>
Date: Wed, 07 Feb 2001 13:52:28 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Status of loopback
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious if the loopback block driver is stable enough yet to, say 
put a loopback file on a vfat partition.

I have 2 HDs, one windoze, one linux. I can't be sure I won't need to 
keep the vfat partition, so I can't just wipe it out. However, it 
currently has more space on it than my ext2 disc. (200 vs 500 MB)

The question therefore is, is it safe to do this yet?? I want to move 
some stuff to the other disc, but don't want the troubles of 
permissions. (BTW, IIRC umsdos doesn't to Win9x LFNs, right. Otherwise I 
could remount umsdos [assuming that it works again. It was broken 
sometime around 2.3.20]).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
