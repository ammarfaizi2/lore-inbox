Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRDPXyL>; Mon, 16 Apr 2001 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDPXxy>; Mon, 16 Apr 2001 19:53:54 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:2317 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S132425AbRDPXxB>; Mon, 16 Apr 2001 19:53:01 -0400
Message-ID: <3ADB85CC.FA9C60A3@netpathway.com>
Date: Mon, 16 Apr 2001 18:52:44 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

> Can the folks who are seeing crashes running athlon optimised kernels all mail
> me
>
> -       CPU model/stepping

vendor_id      : AuthenticAMD
cpu family      : 6
model            : 4
model name   : AMD Athlon(tm) Processor
stepping         : 2
cpu MHz       : 1009.002
cache size      : 256 KB


> -       Chipset

Asus A7V133/WOA
VIA Technologies, Inc. VT8363/8365

> -       Amount of RAM

Mem:     525275136  469438464   55836672          0  179589120  221396992
-/+ buffers/cache:          68452352  456822784
Swap:             518180864          0  518180864

>
> -       /proc/mtrr output

reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe2000000 (3616MB), size=  32MB: write-combining, count=2
reg07: base=0xe4000000 (3648MB), size=  64MB: write-combining, count=1

>
> -       compiler used

Tried both....
gcc-2.95.3
egcs-2.91.66

>
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Gary White                 Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


