Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266133AbRGQLma>; Tue, 17 Jul 2001 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRGQLmU>; Tue, 17 Jul 2001 07:42:20 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:38156 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S266133AbRGQLmK>;
	Tue, 17 Jul 2001 07:42:10 -0400
Date: Tue, 17 Jul 2001 15:35:12 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
X-X-Sender: <ketil@ketil.np>
To: David Balazic <david.balazic@uni-mb.si>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si>
Message-ID: <Pine.LNX.4.33.0107171532450.1817-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, David Balazic wrote:

> /proc/cpuinfo gives :
> cache size: 64 KB
>
> This is wrong :
>  - the Duron has 192 kilobytes of cache ( 64 L1 I, 64 L1 D , 64 L2 unified )
>  - what is KB ?
>    - "kilo" is abbreviated to 'k' , not 'K'
>    - "B" means "Bell" :-)

I believe it is normal to write 'K' for 1024, 'k' for 1000 and 'B' for
bytes and 'b' for bits.

Have a look at acronymfinder.com, they distinguish the capital and
lowercase b for bits and bytes.

Ketil

