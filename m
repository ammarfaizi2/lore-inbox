Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSLKWx1>; Wed, 11 Dec 2002 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSLKWx1>; Wed, 11 Dec 2002 17:53:27 -0500
Received: from dhcp5.colorado-research.com ([65.171.192.245]:24710 "EHLO
	dhcp5.colorado-research.com") by vger.kernel.org with ESMTP
	id <S263326AbSLKWx0>; Wed, 11 Dec 2002 17:53:26 -0500
Message-ID: <3DF7C376.8050408@cora.nwra.com>
Date: Wed, 11 Dec 2002 16:00:06 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on linux 2.4.20-ac1
References: <3DF6291C.3090100@cora.nwra.com> <1039554145.14175.70.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Random lockups on dual athlons are a notorious problem under all OS's.
>Start by checking it passes memtest86, that will verify the RAM is ok -
>and the AMD is -very- picky about RAM.
>
>If thats ok then let me know which board you have, what is plugged into
>it and what PSU you are using.
>
>  
>

memtest86 completed 3 passes with no errors, so:

MB:
Asus A7M266-D w/ Dual Athlon 2100 MP and 4 x 512MB PC2100 ECC Dimms
AMD 762 Chipset
RAM clocking is "normal"

Cards:
PCI 3com 3c905-TX ethernet
PCI Tekram DC-390U3W SCSI Controller
PCI ATI 3d Rage II Video

1 IDE Hard disk
1 external SCSI disk

PSU is a Turbo-Cool 475 ATX-PFC  (appears to be 460W)



