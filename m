Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280255AbRKEGka>; Mon, 5 Nov 2001 01:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280262AbRKEGkW>; Mon, 5 Nov 2001 01:40:22 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:42489 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S280255AbRKEGkL>; Mon, 5 Nov 2001 01:40:11 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: news
From: Wei Xiaoliang <weixl@caltech.edu>
Newsgroups: mlist.linux.kernel
Subject: How can I know the number of current users in the system?
Date: Sun, 04 Nov 2001 22:15:23 +0000
Organization: CS.Caltech.EDU
Message-ID: <3BE5BDFB.B49A8147@caltech.edu>
Reply-To: weixl@caltech.edu
NNTP-Posting-Host: 137-pppold-its.caltech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: en, zh, zh-CN, af, zh-TW
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi every one,
    I have a problem not clear: Is there any counter for the user number
in linux?
I want to do anexperiment which will get the number of current user in
the system and try fair-share scheduling based on it. I read the sys.c
and user.c but cannot find a counter for it. Is there any counter for
this things?

    If no, where can I put the inc instruct and dec instruct  or the
counter? in the uid_hash_insert and uid_hash_remove?
    Thank you!
-----------------------------------------------------------------------
Xiaoliang (David) Wei                    Graduate Student in CS, Caltech
E-mail: weixl@caltech.edu                Office: 158 Jorgensen
Phone: 1-(626)-395-3555 (O)        1-(626)-577-5238 (H)
Mail:     Xiaoliang Wei, 256-80 Caltech, Pasadena, CA 91125, U.S.A.
WWW: http://www.cs.caltech.edu/~weixl    http://166.111.69.241/~wxl
-----------------------------------------------------------------------
