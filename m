Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDNRs1>; Sat, 14 Apr 2001 13:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRDNRsJ>; Sat, 14 Apr 2001 13:48:09 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:517 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132491AbRDNRrz>; Sat, 14 Apr 2001 13:47:55 -0400
Date: Sat, 14 Apr 2001 19:47:43 +0200
From: Kurt Roeckx <Q@ping.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
Message-ID: <20010414194743.A13576@ping.be>
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 04:12:09PM +0100, Alan Cox wrote:
> Can the folks who are seeing crashes running athlon optimised kernels all mail
> me

Just trying to privide you with usefull info.  I'm NOT seeing any
crashes at all.

> -	CPU model/stepping

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.190
cache size      : 256 KB

> -	Chipset

VIA KT133/KM133
(An Asus A7V)

> -	Amount of RAM

128 MiB

> -	/proc/mtrr output

No support for it compiled in.

> -	compiler used

gcc version 2.95.3 20010315 (release)
(compiled myself)


Kurt

