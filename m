Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTBHOEt>; Sat, 8 Feb 2003 09:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBHOEt>; Sat, 8 Feb 2003 09:04:49 -0500
Received: from webmail29.rediffmail.com ([203.199.83.39]:63369 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S266996AbTBHOEt>;
	Sat, 8 Feb 2003 09:04:49 -0500
Date: 8 Feb 2003 14:20:09 -0000
Message-ID: <20030208142009.17031.qmail@webmail29.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: File systems in embedded devices
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

We are developing a embedded device based on linux. Through the 
development phase we used NFS. But now we want to move some 
filesystem
which can be created in FLASH/RAM.

I have few doubts about the file system in embedded devices.

1) What is the file system which is used normally in all embedded 
devices? (JFFS/CRAMFS/RAM DISK)

2) We tried using RAM disk as the file system. But since our 
application is huge it is not able to fit into 8 MB RAM disk 
created. When we tried to increase the size of the RAM disk, the 
kernel crashes above 9 MB. We have 32 MB in our target board.

3) I dont know whether we can use cramfs.

Can anybody suggest me some ideas so that i can solve these 
issues?

Thanks and Regards,
Nanda

