Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSESRnm>; Sun, 19 May 2002 13:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSESRnl>; Sun, 19 May 2002 13:43:41 -0400
Received: from tirith.profinet.sk ([195.46.64.1]:2761 "HELO Tirith.Profinet.sk")
	by vger.kernel.org with SMTP id <S314680AbSESRnl>;
	Sun, 19 May 2002 13:43:41 -0400
Message-ID: <3CE7E431.4070303@profinet.sk>
Date: Sun, 19 May 2002 19:43:13 +0200
From: rasto rickardt <rickardt@profinet.sk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lockd bug still not fixed?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an inode leak in lockd in 2.2.19, caused by a reference 
counting problem as mentioned in 
http://lists.insecure.org/linux-kernel/2000/Sep/0129.html

i have this on 2.2.19 SMP kernel

kernel: grow_inodes: inode-max limit reached in syslog

i searched web and mailing lists if this issue was fixed in 2.4 but i 
did not found any reasonable mention about it.

can someone provide me more information about this?

many thanks

rasto


-- 
rasto rickardt <rickardt@profinet.sk>
Prof-I-NeT SysAdmin
www.profinet.sk
www.host.sk

