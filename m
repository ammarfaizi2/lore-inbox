Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVJBH65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVJBH65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVJBH65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:58:57 -0400
Received: from web35515.mail.mud.yahoo.com ([66.163.179.139]:18090 "HELO
	web35515.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751006AbVJBH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:58:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4DSlMv1UymfQj+a45wkpqjldyaiRc/LY7uHkqWuJe4IhMvdZS4O7k2PkiHF+UHpCK81gfMlnTT5hc1rM9oA/H/5JHXw85VtB1U6C7ZVDXEVw5M2u5uBh9EbGJVmdhtXP3REIgI7n9RLRVsNDNaE2VwYVig1kAprv1uZVgNNPnZQ=  ;
Message-ID: <20051002075855.1277.qmail@web35515.mail.mud.yahoo.com>
Date: Sun, 2 Oct 2005 00:58:55 -0700 (PDT)
From: salman khan <madat_ye_khuda@yahoo.com>
Subject: KGDB Problem on Mandrake 10.0 ...............
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sir,
   I am using kernel 2.6.10 (mandrake 10.0) & same
KGDB patch . I have 
made all connection proper (verified ) , also tested
simple program 
(just using bt , next , step commands ). while using
KGDB for Module i 
have downloaded gdb patch "gdbmod.bz2" from 
www.linsyssoft.com & had 
installed it , i have placed that "gdbmod" file
(extracted file) in ' /bin 
' . After giving gdbmod
command it shows me   "Permission denied " message so
then i changed 
the rights & made it executable. while giving gdbmod
command to 'vmlinux' 
on
developement m/c i got sementation fault .      
 
[root@localhost linux-2.6.10]# gdbmod vmlinux
GNU gdb 6.0
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General
Public License, and you are
welcome to change it and/or distribute copies of it
under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show
warranty" for details.
This GDB was configured as
"i686-pc-linux-gnu"...Segmentation fault (core dumped)
What is wrong with this ?
Please help me.
 
mail me : shashank_pict@yahoo.com
 
                                    - Shashank K.
                                      PICT , PUNE 



		


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
