Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261959AbRENF30>; Mon, 14 May 2001 01:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbRENF3Q>; Mon, 14 May 2001 01:29:16 -0400
Received: from nwcst340.netaddress.usa.net ([204.68.23.85]:24976 "HELO
	nwcst340.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S261959AbRENF3F> convert rfc822-to-8bit; Mon, 14 May 2001 01:29:05 -0400
Message-ID: <20010514052904.22912.qmail@nwcst340.netaddress.usa.net>
Date: 13 May 2001 23:29:04 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: How VFS interacts with a file driver
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
               I am trying to implement a distributed file system. For that I
write a file driver. I want to know the following things

1 . If I am writing a new file system, is it necessary to modify the existing
structs including inode struct. 
2 . If it is not needed, will a simple registration of the file system is
needed to mount the file system
                More over I am new to this area. I am doing as my graduate
project. I need someones help to crack the working of VFS
Thanks in advance
                          Blesson Paul

____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
