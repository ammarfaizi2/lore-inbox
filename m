Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDOHyi>; Sun, 15 Apr 2001 03:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132595AbRDOHy2>; Sun, 15 Apr 2001 03:54:28 -0400
Received: from mail1.rdc2.bc.home.com ([24.2.10.84]:53957 "EHLO
	mail1.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S132587AbRDOHyS>; Sun, 15 Apr 2001 03:54:18 -0400
Date: Mon, 16 Apr 2001 00:42:31 -0700 (PDT)
From: ecksfantom@home.com
To: "Matthew W. Lowe" <swds.mlowe@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <3ADA49F0.A412EAA@home.com>
Message-ID: <Pine.LNX.4.21.0104160037230.19394-100000@maelstrom.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had the same problem when i upgraded to 2.4.2. 
Upgrading to the latest modutils
(ftp://ftp.kernel.org/pub/linux/utils/modutils/v2.4/modutils-2.4.5.tar.gz)
should get you going again.

~Jarrod

On Sun, 15 Apr 2001, Matthew W. Lowe wrote:

> I just tried to upgrade from whatever kernel comes with redhat to 2.4.3.
> The build, install and such was smooth. When I got to starting up,
> everything appeared to work, until it got to my NIC cards. Neither of
> them loaded properly. I've built in the EXACT same module for the NICs
> as I did the previous kernel. They were the NE2000 PCI module and the
> 3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
> III ISA. Both are PNP, the etherlink is NOT the one with the b extention
> at the end.
> 
> Any help would be greatly appriciated.
> 
> Thanks,
>    Matt
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

