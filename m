Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbTCMEPk>; Wed, 12 Mar 2003 23:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262153AbTCMEPk>; Wed, 12 Mar 2003 23:15:40 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:23454 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP
	id <S262148AbTCMEPj>; Wed, 12 Mar 2003 23:15:39 -0500
Message-ID: <3E70086B.6080408@lemur.sytes.net>
Date: Wed, 12 Mar 2003 23:26:19 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: support for/detection of  new VIA C3 core
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [68.162.36.8] at Wed, 12 Mar 2003 22:26:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any plans to supports this new CPU core in 2.4 ?
i.e. it now supports SSE and no longer 3dnow (as reported
by the kernel).

[root@cinemax rc5.d]# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 8
model name      : VIA C3 Ezra
stepping        : 9
cpu MHz         : 999.910
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1989.22

