Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRL0Vmd>; Thu, 27 Dec 2001 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282655AbRL0VmY>; Thu, 27 Dec 2001 16:42:24 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:14196 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S282860AbRL0VmN>; Thu, 27 Dec 2001 16:42:13 -0500
Posted-Date: Thu, 27 Dec 2001 21:42:04 GMT
Date: Thu, 27 Dec 2001 21:42:04 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <8FeKi-zXw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.21.0112272136210.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai.

> rhw@MemAlpha.cx (Riley Williams) wrote on 26.12.01...

>>			Symbol	Designation	  Number of Bytes
>>			~~~~~~	~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~~~~
>>			KiB	Decimal Kilobyte  1,000
>>			KB	Binary Kilobyte   1,024
>>
>>			MiB	Decimal Megabyte  1,000,000
>>			MB	Binary Megabyte   1,048,576
>>
>>			GiB	Decimal Gigabyte  1,000,000,000
>>			GB	Binary Gigabyte   1,073,741,824
>>
>>			TiB	Decimal Terabyte  1,000,000,000,000
>>			TB	Binary Terabyte   1,099,511,627,776

> Uh, that's all wrong. The "i" versions are *binary*, the non-"i"
> versions are *decimal*. Completely backward.

No problem. Just swap the relevant labels over in the first column.

As far as the tweak I proposed (and which I've finished creating for
`make config` and have nearly finished for `make menuconfig` as well),
the whole entry, along with that for any other "Technical Acronyms"
(TM) that one wishes to define in the same way, are simple entries at
the top of Configure.help and can easily be edited by anybody willing
to apply fingers to keycaps.

The only question I'm really interested in hearing answers to is this:

	What other acronyms used in Configure.help could use
	defining in this manner for kernel newbies?

Any takers willing to supply both the acronym and a definition thereof?

Best wishes from Riley.

