Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbTBWKJw>; Sun, 23 Feb 2003 05:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268127AbTBWKIs>; Sun, 23 Feb 2003 05:08:48 -0500
Received: from [203.200.144.45] ([203.200.144.45]:15882 "EHLO
	mx-out-01.nestec.net") by vger.kernel.org with ESMTP
	id <S268120AbTBWKHv>; Sun, 23 Feb 2003 05:07:51 -0500
Organization: NeST-India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A5153A6B@pdc2.nestec.net>
From: SANTHOSH K <santhoshk@nestec.net>
To: "'Willy Tarreau'" <willy@w.ods.org>, SANTHOSH K <santhoshk@nestec.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: QUERY: Porting Linux kernel to Toshiba TX4927
Date: Sun, 23 Feb 2003 15:28:15 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi willy,

but arch/mips arch/mips64 only saying about Toshiba TX3927

Santhosh K

-----Original Message-----
From: Willy Tarreau [mailto:willy@w.ods.org]
Sent: Sunday, February 23, 2003 2:16 PM
To: SANTHOSH K
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: QUERY: Porting Linux kernel to Toshiba TX4927



Hi !
 
On Sun, Feb 23, 2003 at 01:02:09PM +0530, SANTHOSH K wrote:
> 1. Has somone already ported Linux to TX4927 chip?

Toshiba's press release says it's supported. You may try to verify this in
the
mips tree (at least, there's the 3927).

> 3. If yes, then who is maintaining it. We could not get any information
from
> the source tree.
> 4. If yes, is it an open source? where can I get the source code.

Look in arch/mips and/or arch/mips64 if you find what you want.

a quick search for "tx4927 linux" on google will bring you to toshiba's PR
and
montavista's products.

Willy
