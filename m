Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279275AbRJ2Mco>; Mon, 29 Oct 2001 07:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279276AbRJ2Mce>; Mon, 29 Oct 2001 07:32:34 -0500
Received: from downhill.barcelo.com ([195.57.250.31]:40892 "HELO
	downhill.barcelo.com") by vger.kernel.org with SMTP
	id <S279275AbRJ2Mc0>; Mon, 29 Oct 2001 07:32:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Joan Batet <j.batet@barcelo.com>
Organization: Viajes Barcelo
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HIGMEM, SMP, 2.4.13 and Cerberus
Date: Mon, 29 Oct 2001 13:34:15 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011029123256.3FA173F310@downhill.barcelo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I've got a little problem with a new computer we have on our company. The 
problem is what I try run Cerberus to test the stability of this computer 
with a 2.4.13 kernel;  at the first test the computer went down in 15 
minutes; the second test went well, the computer responsivity was good and 
it was appears to be stable. At this moment I'm going to test again to see 
if the machine supports it (I hope that ...).
Well, now the problem and the question: what kernel do you think I must 
put on this computer? I need a rock solid system ... I'm testing 2.4.3 and 
2.4.9 too, but 2.4.13 appears to be the best performance kernel ...
Thanks in advance,
	Joan


The computer:
- Dell PowerEdge 2550
- Dual PIII 1Ghz
- 2Gb ECC SDRAM
- 2 x 36Gb RAID1 (AACRAID)

Linux TESTING 2.4.13 #1 SMP Fri Oct 26 12:30:37 CEST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11f
mount                  2.11f
modutils               2.4.5
e2fsprogs              1.24
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded
