Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317629AbSGFL3y>; Sat, 6 Jul 2002 07:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317631AbSGFL3x>; Sat, 6 Jul 2002 07:29:53 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:3456 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317629AbSGFL3x>; Sat, 6 Jul 2002 07:29:53 -0400
Date: Sat, 6 Jul 2002 13:12:32 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: =?iso-8859-1?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020706131232.B807@linux-m68k.org>
References: <003201c224cd$e25df820$0201a8c0@witek>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <003201c224cd$e25df820$0201a8c0@witek>; from adasi@kernel.pl on Sat, Jul 06, 2002 at 11:16:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 11:16:49AM +0200, Witek Krêcicki wrote:
> I'm looking for /proc/cpuinfo output from following architectures: arm m68k
> mips s390 sparc.
> I need it but I don't have access to any of them :/

# cat /proc/cpuinfo 
CPU:            68060
MMU:            68060
FPU:            68060
Clocking:       65.7MHz
BogoMips:       131.48
Calibration:    657408 loops

Variations: CPU:68020,68030,68040,68060
	    MMU:68851,Sun-3,Apollo (CPU 020 only),68040,68060
     	    FPU:68881,68882 (CPU 020 and 030 only)
		"none(soft float)",68040,68060
