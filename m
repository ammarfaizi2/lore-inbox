Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVLNBsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVLNBsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLNBsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:48:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40786 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030413AbVLNBsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:48:04 -0500
Date: Tue, 13 Dec 2005 20:47:58 -0500
From: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>
Subject: bugs?
To: linux-kernel@vger.kernel.org
Cc: coywolf@gmail.com
Message-id: <439F79CE.6040609@ens.etsmtl.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my cpu is 1400MHz, but why there's cpu MHz         : 598.593

caro@olymphe:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1400MHz
stepping        : 5
cpu MHz         : 598.593
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
bogomips        : 1186.66

