Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284488AbRLIV6Z>; Sun, 9 Dec 2001 16:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284520AbRLIV6O>; Sun, 9 Dec 2001 16:58:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51216 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284500AbRLIV5s>; Sun, 9 Dec 2001 16:57:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: On re-working the major/minor system
Date: 9 Dec 2001 13:57:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9v0mo1$ms$1@cesium.transmeta.com>
In-Reply-To: <9urbtm$69e$1@cesium.transmeta.com> <9urbtm$69e$1@cesium.transmeta.com> <20011207145535.A18152@codepoet.org> <8EWhHLVmw-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <8EWhHLVmw-B@khms.westfalen.de>
By author:    kaih@khms.westfalen.de (Kai Henningsen)
In newsgroup: linux.dev.kernel
> 
> > The C library, and the POSIX standard, etc, etc.
> 
> I think you'll find that there is *NOTHING* in either the C standard,  
> POSIX, or the Austin future-{POSIX,UNIX} standard that knows about major  
> or minor numbers.
> 

It's not "future" anymore... Austin is now IEEE 1003.1-2001 and thus
the new POSIX standard.

Anyway, look for things like tar, cpio, ISO 9660 and that class of
standards.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
