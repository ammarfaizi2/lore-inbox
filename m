Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSF3OpU>; Sun, 30 Jun 2002 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSF3OpT>; Sun, 30 Jun 2002 10:45:19 -0400
Received: from gemini.rz.uni-ulm.de ([134.60.246.16]:10667 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S315210AbSF3OpS>; Sun, 30 Jun 2002 10:45:18 -0400
Message-ID: <1025448452.3d1f1a04e4477@imap.rz.uni-ulm.de>
Date: Sun, 30 Jun 2002 16:47:32 +0200
From: monjur.morshed@student.uni-ulm.de
To: root@porky.devel.redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Driver for sis900 network card
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 134.60.112.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir I tried several times to inatall driver for redhat linux 7.1. 
I tried all the instruction followed from this page.
<http://www.sis.com/support/driver/linux.htm>. In the lan driver section from 
the "Readme" file section 5 is as follows.

5. Recompile the kernel by
   #make bzlilo
   After the compilation finished there will be two file in / directory
   #ls -al /
   -rw-r--r--   1 root     root       298358 Jan 25 11:49 System.map
   -rw-r--r--   1 root     root       545835 Jan 25 11:49 vmlinuz
   If you are using RedHat move these two file to /boot

But after doing so I cant the Sytem.map and vmlinuz. After giving the "make 
bzlilo" compilation starts and after finishing it says 2 errors.(make ***(-dir-
drivers)). My kernel version is now 2.4.2-2. I need to have driver for lan 
card. Would you please help me. I need tar or rpm directly for this. 


Sincerely yours

Monjur Morshed
