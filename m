Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDOPXz>; Sun, 15 Apr 2001 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRDOPXp>; Sun, 15 Apr 2001 11:23:45 -0400
Received: from mout01.kundenserver.de ([195.20.224.132]:43273 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132686AbRDOPXb>; Sun, 15 Apr 2001 11:23:31 -0400
Date: Sun, 15 Apr 2001 15:57:06 +0200
From: Heinz Diehl <>
To: linux-kernel@vger.kernel.org
Subject: Re: "uname -p" prints unknown for Athlon K7 optimized kernel?
Message-ID: <20010415155706.A188@elfie>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3AD92D3B.EBBFC504@yk.rim.or.jp> <3AD933E5.5908BE2E@classical.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17-current-20010414i (Linux 2.4.3 i586)
In-Reply-To: <3AD933E5.5908BE2E@classical.2y.net>; from linux@classical.2y.net on Sun, Apr 15, 2001 at 01:38:45PM +0800
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Apr 15 2001, joker wrote:

> i have this problem using intel 850mhz and 333mhz
> any know where to get update version of uname ?

http://www.tuxfinder.com

Btw:

elfie:~ # uname --version
uname (GNU sh-utils) 2.0.11
Written by David MacKenzie.

Copyright (C) 2000 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
elfie:~ # uname -p
unknown

elfie:~ # uname -a
Linux elfie 2.4.3 #1 Fri Apr 13 21:08:29 CEST 2001 i586 unknown

elfie:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 400.917
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 799.53

-- 
# Heinz Diehl, 68259 Mannheim, Germany
# Groovebox Roland MC-303, Digitech RP-1 and Fender Stratocaster for sale,
# all in mint condition! Further information via e-mail.
