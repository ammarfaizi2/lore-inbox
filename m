Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGFMrd>; Sat, 6 Jul 2002 08:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSGFMrc>; Sat, 6 Jul 2002 08:47:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25867 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315503AbSGFMrb>;
	Sat, 6 Jul 2002 08:47:31 -0400
Date: Sat, 6 Jul 2002 13:50:05 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Witek Kr?cicki <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020706125005.GD2784@gallifrey>
References: <003201c224cd$e25df820$0201a8c0@witek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201c224cd$e25df820$0201a8c0@witek>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 13:47:51 up 17:41,  1 user,  load average: 1.99, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Witek Kr?cicki (adasi@kernel.pl) wrote:
> I'm looking for /proc/cpuinfo output from following architectures: arm m68k
> mips s390 sparc.

Well here are mips and m68k; I don't have an ARM box bootable at the
moment:

This is from my SG Indy (Dino):

>>>>>>>>>>>>>>>>>>>>>>
cpu			: MIPS
cpu model		: R4600 V2.0
system type		: SGI Indy
BogoMIPS		: 132.71
byteorder		: big endian
unaligned accesses	: 0
wait instruction	: yes
microsecond timers	: yes
extra interrupt vector	: no
hardware watchpoint	: no
VCED exceptions		: not available
VCEI exceptions		: not available
>>>>>>>>>>>>>>>>>>>>>>

And the following shows the stunning computing power of my Sun 3/60:

>>>>>>>>>>>>>>>>>>>>>>
CPU:		68020
MMU:		Sun-3
FPU:		68881
Clocking:	19.3MHz
BogoMips:	4.83
Calibration:	24192 loops
>>>>>>>>>>>>>>>>>>>>>>

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
