Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282134AbRKWLwy>; Fri, 23 Nov 2001 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282128AbRKWLwp>; Fri, 23 Nov 2001 06:52:45 -0500
Received: from andromeda.veritel.com.br ([200.230.193.1]:59562 "HELO
	veritel.com.br") by vger.kernel.org with SMTP id <S282127AbRKWLwf>;
	Fri, 23 Nov 2001 06:52:35 -0500
Message-ID: <3BFE3938.10104@veritel.com.br>
Date: Fri, 23 Nov 2001 09:55:36 -0200
From: "William N. Zanatta" <william@veritel.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ZIP drive is not working fine...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

   Problem:

     When I try do to something like mkfs on my ZIP disks, it hangs the 
system as if it couldn't find or work on the drive.
     I have applied the 'ide-floppy update to fix lockups with ZIP + Via 
chipset' on my kernel but...it still doesn't work. Now I get this 
message on my syslog:

        ide-floppy: CoD != 0 in idefloppy_pc_intr

     The drive make transfers fine, the only problem until now is this 
with mkfs. I didn't have time to spend on my machine for this moment to 
get some debug info but I will do it as soon as possible. But if you can 
solve my problem or give me some tips, it would be great!
     Sorry for my poor English.

   System:
     Athlon 1.2Ghz running on a Abit KT7A-R board
     256mb RAM
     NEC's IDE ZIP drive
     Running Slackware 8 and Kernel 2.4.14


   Thank you all,

William N. Zanatta

