Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284886AbRLSMir>; Wed, 19 Dec 2001 07:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbRLSMi2>; Wed, 19 Dec 2001 07:38:28 -0500
Received: from mailgate.ics.forth.gr ([139.91.1.2]:28065 "EHLO
	ext1.ics.forth.gr") by vger.kernel.org with ESMTP
	id <S284886AbRLSMiQ>; Wed, 19 Dec 2001 07:38:16 -0500
Message-ID: <3C208B2A.5070803@iesl.forth.gr>
Date: Wed, 19 Dec 2001 14:42:18 +0200
From: Thodoris Pitikaris <linux@iesl.forth.gr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: problem with smb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In our institute we have a cluster system with 6 sytems that have the 
following
configuration :

CPU: PIII 1GHZ/133 MHZ (DUAL)
MOTHER: Intel Server Board STL2 (intergrated Intel pro/100+ & Adaptec 
Ultra 160 SCSI) Chipset ServerWorks OSB4
NET CARD: 3COM Broadcom BCM5700 (Gigabit)
RAID Cont. : AMI MegaRAID (only in PBS server)
HDD: IBM       Model: DDYS-T18350N
MEMORY: 512MB/133Mhz
OS: REDHAT 7.1 with Default Kernel (2.4.7)

What the problem is : The PBS server after some time freeze, with no 
error message from kernel Just freeze. We have changed everthing (even 
the tower)
but nothing happened !

Is there any sugestions ?

Best Regards

--thodoris

