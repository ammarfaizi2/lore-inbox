Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272021AbRHVO6q>; Wed, 22 Aug 2001 10:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272022AbRHVO6g>; Wed, 22 Aug 2001 10:58:36 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:7354 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272021AbRHVO62>; Wed, 22 Aug 2001 10:58:28 -0400
Date: Wed, 22 Aug 2001 10:58:41 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <200108220615.IAA16563@ns.cablesurf.de>
Message-ID: <Pine.GSO.4.33.0108221053270.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Oliver Neukum wrote:
>> > Oh for the love of God, will you people stop drooling over the fucking
>> > GPL? It's *firmware*... it's just a bunch of bits.  It's *not* a program
>> > the kernel executes.  It's just data. (__init_data to be exact.)
>>
>> Look, if its not distributable then its no good to anyone.
>
>Are you allowed to distribute an initrd that contains it, build from it and
>GNU tools ?

Depends on who's interpreting the license.  I say as long as the source to
the whole mess is available (even provided *with* the binaries), you aren't
violating anything.  On the otherhand, strictly speaking, once the file
is compiled, it becomes "in binary form" which needs the notice attached to
it in some way -- like all the fine print one finds on any box of stuff from
Sun, Compaq/Digital, Cisco, etc.

However, as others have said, none of us are lawyers.  Of course, none of us
have been sued by Qlogic either.

--Ricky


