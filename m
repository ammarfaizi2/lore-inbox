Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268072AbTBWIvL>; Sun, 23 Feb 2003 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268076AbTBWIvL>; Sun, 23 Feb 2003 03:51:11 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5902 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S268072AbTBWIvK>;
	Sun, 23 Feb 2003 03:51:10 -0500
Date: Sun, 23 Feb 2003 09:45:48 +0100
From: Willy Tarreau <willy@w.ods.org>
To: SANTHOSH K <santhoshk@nestec.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: QUERY: Porting Linux kernel to Toshiba TX4927
Message-ID: <20030223084548.GE5411@alpha.home.local>
References: <F6E1228667B6D411BAAA00306E00F2A5153A6A@pdc2.nestec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A5153A6A@pdc2.nestec.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !
 
On Sun, Feb 23, 2003 at 01:02:09PM +0530, SANTHOSH K wrote:
> 1. Has somone already ported Linux to TX4927 chip?

Toshiba's press release says it's supported. You may try to verify this in the
mips tree (at least, there's the 3927).

> 3. If yes, then who is maintaining it. We could not get any information from
> the source tree.
> 4. If yes, is it an open source? where can I get the source code.

Look in arch/mips and/or arch/mips64 if you find what you want.

a quick search for "tx4927 linux" on google will bring you to toshiba's PR and
montavista's products.

Willy

