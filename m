Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSFAGqr>; Sat, 1 Jun 2002 02:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFAGqq>; Sat, 1 Jun 2002 02:46:46 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:39126 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316889AbSFAGqp>; Sat, 1 Jun 2002 02:46:45 -0400
Message-ID: <3CF86DBA.2050008@wanadoo.fr>
Date: Sat, 01 Jun 2002 08:46:18 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.19 devfs partition naming
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to give this to grub for being able to mount the root fs 
(/dev/hde3) at boot time :

root=/dev//dev/ata/host2/bus0/target0/lun0/part2

Is it a typo in the naming of partition for devfs ?

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

