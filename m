Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136114AbRECFCl>; Thu, 3 May 2001 01:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbRECFCc>; Thu, 3 May 2001 01:02:32 -0400
Received: from mail.gator.com ([63.197.87.182]:2316 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S136114AbRECFCR>;
	Thu, 3 May 2001 01:02:17 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: Crusoe math performance?
Date: Wed, 2 May 2001 22:04:41 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIENPCOAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I am fooling around with one of these things:

processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 5
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5600
stepping        : 3
cpu MHz         : 533.348
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 cmov mmx longrun
bogomips        : 1032.19

Anyone have any idea of FPU performance? I mean, compared to a Celeron or
Pentium in an application running an SSL web server would I expect 80%,
100%, 10%, 110% of the throughput of a Intel chip of the same clock speed?
Just thought this thing might be a good alternative to a Pentium SSL server
"furnace" and am looking for any comments from anyone that might have tested
it.  If I don't hear anything, I will post the numbers we come up with when
we get around to benchmarking them.

