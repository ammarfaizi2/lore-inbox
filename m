Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312735AbSDBBoN>; Mon, 1 Apr 2002 20:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312737AbSDBBoD>; Mon, 1 Apr 2002 20:44:03 -0500
Received: from grumpy.usu.edu ([129.123.1.86]:60430 "EHLO grumpy.usu.edu")
	by vger.kernel.org with ESMTP id <S312735AbSDBBn5>;
	Mon, 1 Apr 2002 20:43:57 -0500
Date: Mon, 01 Apr 2002 18:43:54 -0700
From: "Napanda. C. Pemmaiah" <pemmaiah@cc.usu.edu>
Subject: Confirmation!
To: netdev@oss.sgi.com
Message-id: <3CABC1F5@webmail.usu.edu>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.62
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 7bit
X-WebMail-UserID: pemmaiah
X-EXP32-SerialNo: 00002751
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
       How are you? I am Anup Pemmaiah doing my masters in computer science at 
Utah State University -USA. I have a linux box running Red Hat 7.2 (kernel 
version 2.4). My ethernet driver is 3c59x. I had two questions regarding 3c59x 
module installation.

1)  When the system is booted the module gets installed. I was curious from 
where does this installation takes place. As far i learnt from the 
documentation, this is done because of the entry "alias eth0 3c59x" in the 
/etc/modules.conf file. But even if I delete this entry and reboot the system 
still the module gets installed.

2)          I removed the module by "rmmod 3c59x" and again installed it by 
"insmod /lib/modules/...../net/3c59x.o". The module got installed but in the 
/proc/modules it shows "3c59x    0(unused)". And from /etc/rc.d/init.d if I 
start the network by saying "./network start" the eth0 conncetion does not 
come up. Is it because of some options setting to be done during insmod. I 
searched and tried a lot but I could not figure out the above two problems.

            It will be really great if you can give the solution for the above 
problems. I will be eagerly waiting for your reply. I am sorry for disturbing 
you. Have a nice day.

Thank you,
Anup Pemmaiah

-------------------------------------------------
N.C.Pemmaiah (Anup)
620E, 700N, Apt# 2
Logan, UT-84321,USA.
email: pemmaiah@cc.usu.edu, anup_pemmaiah@yahoo.com
Ph: 435-512-0935(mob.), 435-752-5976 (Res.)
-------------------------------------------------

