Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVIYDzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVIYDzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 23:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIYDzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 23:55:41 -0400
Received: from web52407.mail.yahoo.com ([206.190.48.170]:57692 "HELO
	web52407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751087AbVIYDzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 23:55:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HfspXT4+lg4Rvvysb+Ye+ImhkCQ5sr8QifPSZW76Dq81KlNd2LunIcE5ssmUO5ftpQj46l6yUYtD5poql8a+0JKHiyPEUxmSB1DikTYHwuzW1s+N0YF1QrWgf77sSjgMbDGUUOOXZ/8zzvuohxhVG+bOyTC6xjTtCnETY7EXvV8=  ;
Message-ID: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
Date: Sat, 24 Sep 2005 20:55:39 -0700 (PDT)
From: anup badhe <anup_223@yahoo.com>
Subject: patching kgdb to linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am trying to debug the linux kernel 2.6.10 using
kgdb.i have downloaded the kgdb patch 2.6.10-mm2.bz2.
after bunzip2 it gives me the file 2.6.10-mm2.

problem:
1- which type of file is this?
2- what patch command should i use(the options) so
that i can patch it to linux 2.6.10.?
3-i have used the following command and it gives me
some errors:

root@localhost root]# patch -p1 <2.6.10-mm2
can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this
was:--------------------------|---
linux-2.6.10/arch/alpha/defconfig  2004-10-18
16:55:19.000000000 -0700
|+++ 25/arch/alpha/defconfig    2005-01-05
23:22:42.000000000 -0800
--------------------------
File to patch:


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
