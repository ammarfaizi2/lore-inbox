Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRKOBPx>; Wed, 14 Nov 2001 20:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRKOBPo>; Wed, 14 Nov 2001 20:15:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279547AbRKOBPZ>; Wed, 14 Nov 2001 20:15:25 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: fdutils.
Date: 14 Nov 2001 17:15:07 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9sv4ur$buj$1@cesium.transmeta.com>
In-Reply-To: <20011114123033.N991@zip.com.au> <Pine.LNX.4.21.0111150027200.3058-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0111150027200.3058-100000@Consulate.UFP.CX>
By author:    Riley Williams <rhw@MemAlpha.cx>
In newsgroup: linux.dev.kernel
> 
> As I see it, there are the following options available:
> 
>  1. Insist that those using the rescue CD have two CD drives.
> 
>     In my book, that's a non-starter, so 'nuff said).
> 
>  2. Prohibit access to the CD drive for anything other than the
>     rescue CD.
> 
>  3. Copy the contents of the CD into a ramdisk, then run from
>     the ramdisk.
> 
>     If the user has enough RAM, maybe, but if not...
> 
>  4. Provide a "Virtual CD Drive" on single CD drive systems
>     (similar to the way drive B: on MS-DOS 2.00 and later is a
>     virtual floppy drive on single floppy systems).
> 
>     I'm not sure how this would work in practice, but it could
>     be done, I'm sure.
> 

All of this is why different rescue-CD distributions take different
approaches... as well as those that use other means such as floppy- or
network-booting.

One size doesn't necessarily fit all, and that's just fine.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
