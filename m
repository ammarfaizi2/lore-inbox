Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbQKSVLY>; Sun, 19 Nov 2000 16:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130265AbQKSVLO>; Sun, 19 Nov 2000 16:11:14 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:57730 "EHLO
	mail.mirai.cx") by vger.kernel.org with ESMTP id <S130148AbQKSVLC>;
	Sun, 19 Nov 2000 16:11:02 -0500
Message-ID: <3A183ADA.C92B87BB@pobox.com>
Date: Sun, 19 Nov 2000 12:40:58 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gianluca Anzolin <g.anzolin@inwind.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: XMMS not working on 2.4.0-test11-pre7
In-Reply-To: <20001119150645.A732@fourier.home.intranet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a data point

I'm listening to mp3s now via xmms, running 2.4.0-test11-pre7

# uname -r -s
Linux 2.4.0-test11-pre7
# rpm -q xmms
xmms-1.2.3-0_helix_1

the "flags/features" switch doesn't seem to hurt it:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.000038
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 901.12


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
