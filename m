Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319605AbSIHNLh>; Sun, 8 Sep 2002 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319606AbSIHNLh>; Sun, 8 Sep 2002 09:11:37 -0400
Received: from web14701.mail.yahoo.com ([216.136.224.118]:36684 "HELO
	web14701.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319605AbSIHNLg>; Sun, 8 Sep 2002 09:11:36 -0400
Message-ID: <20020908131618.21467.qmail@web14701.mail.yahoo.com>
Date: Mon, 9 Sep 2002 01:16:18 +1200 (NZST)
From: =?iso-8859-1?q?thomas=20joseph?= <thomascanny@yahoo.co.nz>
Subject: interval timers and sleep in linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,
 I am porting an application from windows to linux.
 The application uses both interval timesr and sleep.

 I came to know that in Linux we can not use both
 setitimer and sleep in the application. Because both 
 of them rely on SIGALRM.

 Can somebody tell me how to come out of this problem.

Thanks and Regards,

 --thomas



http://mobile.yahoo.com.au - Yahoo! Messenger for SMS
- Now send & receive IMs on your mobile via SMS
