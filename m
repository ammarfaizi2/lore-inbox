Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbSIWHvf>; Mon, 23 Sep 2002 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264704AbSIWHve>; Mon, 23 Sep 2002 03:51:34 -0400
Received: from mail.dia.uniroma3.it ([193.204.161.133]:33298 "EHLO
	mail.dia.uniroma3.it") by vger.kernel.org with ESMTP
	id <S263118AbSIWHve>; Mon, 23 Sep 2002 03:51:34 -0400
Message-ID: <3D8EC95A.8060103@dia.uniroma3.it>
Date: Mon, 23 Sep 2002 09:57:14 +0200
From: Milicchio Franco <milicchi@dia.uniroma3.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en, it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: APM hangup on shutdown
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shutdown hangs up after shutting down APM daemon with APM module.

Using the APM kernel module, when shutting down, the system freezes 
after shutting down the APM daemon.

After using a built-in-kernel APM (not modules) the shutdown works fine.


===== Output of ver_linux =====

Linux bourbaki.dia.uniroma3.it 2.4.19 #3 Mon Sep 23 09:16:26 CEST 2002 
i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod es1371 ac97_codec NVdriver 8139too mii 
ide-scsi scsi_mod printer rtc




