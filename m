Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbTCZO0N>; Wed, 26 Mar 2003 09:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbTCZO0N>; Wed, 26 Mar 2003 09:26:13 -0500
Received: from ns.innomedia.soft.net ([164.164.79.130]:52402 "EHLO
	alabama.innomedia.soft.net") by vger.kernel.org with ESMTP
	id <S261664AbTCZO0N>; Wed, 26 Mar 2003 09:26:13 -0500
Message-ID: <3E81BB1B.3020007@innomedia.soft.net>
Date: Wed, 26 Mar 2003 20:07:15 +0530
From: Akhilesh <sony@innomedia.soft.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Direck IO  on SCSI Disk 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I want to develop a clustere  file system using independent Blade 
servers (about 96 in number) running linux. Each blade  having  2 or 
more SCSI disks attached to it. In order to build our own filesystem  I 
need to  do direct  writing/reading  in the SCSI disk bypassing all the 
kernel level buffering. 

Could you please suggest some information as how to go about it.

Best Regards,
Akhilesh Soni
Innomedia Technologies Pvt Ltd.
India



