Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135178AbRECUBQ>; Thu, 3 May 2001 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbRECUBA>; Thu, 3 May 2001 16:01:00 -0400
Received: from ch-12-44-141-183.lcisp.com ([12.44.141.183]:36357 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S135180AbRECUAi>;
	Thu, 3 May 2001 16:00:38 -0400
Date: Thu, 3 May 2001 15:03:46 -0500
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Info on Athlon/Duron failure as requested
Message-ID: <20010503150346.A18141@debian-home.lcisp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

See attachment for info requested.

Gordon Sadler


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="X988920011-12614-0.gbsadler"
Content-Transfer-Encoding: quoted-printable

From: gbsadler1@lcisp.com (Gordon Sadler)
Subject: Re: Athlon runtime problems
In-Reply-To: <linux.kernel.E14oRie-000556-00@the-village.bc.nu>
Reply-To: gbsadler1@lcisp.com

On  Sat, 14 Apr 2001 16:12:09 +0100 (BST), Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:
> Can the folks who are seeing crashes running athlon optimised kernels
> all mail
> me
>=20
> -	CPU model/stepping
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 801.828
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1599.07
=20
> -	Chipset
VIA KT133A AGPset (KT133A+VT82C686B)

> -	Amount of RAM
128 MB

> -	/proc/mtrr output
$ cat /proc/mtrr
reg00: base=3D0x00000000 (   0MB), size=3D 128MB: write-back, count=3D1

> -	compiler used
$gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010319 (Debian prerelease)

--SUOF0GtieIMvvwua--
