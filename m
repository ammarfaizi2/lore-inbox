Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263379AbREXFlz>; Thu, 24 May 2001 01:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263382AbREXFlg>; Thu, 24 May 2001 01:41:36 -0400
Received: from wwcst269.netaddress.usa.net ([204.68.23.14]:27056 "HELO
	wwcst269.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S263404AbREXFlZ> convert rfc822-to-8bit; Thu, 24 May 2001 01:41:25 -0400
Message-ID: <20010524054123.19472.qmail@wwcst269.netaddress.usa.net>
Date: 23 May 2001 23:41:23 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: no ntfs support]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi srikanth and all
                   I really want to help u. I think u are also in the way of
constructing a new file system. If so we can work together.  I tried to
compile the files in the fs/ntfs directory. But it shows the errors. The
errors is because each file includes many files in the other directories. So
you have to specify these files in the make file. For example if you have to
make the object file of dir.c. then u have to specify which are the files are
included in the dir.c in the make file

dir.o:dir.c current.c......
                    
                   After all, a simple compilation will not solve the problem.
You have to register it. I am in the way to do the above things for ntfs file
system. If u have any questions feel free to ask. 

Thanks in advance
                             by
                                  Blesson 
                   

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
