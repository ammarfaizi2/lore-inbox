Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279998AbRKOCQr>; Wed, 14 Nov 2001 21:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280130AbRKOCQi>; Wed, 14 Nov 2001 21:16:38 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:53265 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S279998AbRKOCQV>;
	Wed, 14 Nov 2001 21:16:21 -0500
Date: Thu, 15 Nov 2001 12:11:24 +1100
From: Anton Blanchard <anton@samba.org>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] arbitrary size memory allocator, memarea-2.4.15-D6
Message-ID: <20011115121124.A22552@krispykreme>
In-Reply-To: <3BF012BE.E82911C0@mandrakesoft.com> <Pine.LNX.4.21.0111131557511.12260-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111131557511.12260-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Please point me to where you found a machine with 100 Gigabytes of RAM
> as I could realy make use of that here...

Really 128GB isnt that much RAM any more, and the negative effects from
deep hash chains will probably start hitting at ~8GB.

Most non-intel architectures (sparc64, alpha, ppc64) have booted Linux
with > 100GB RAM - we have run 256GB ppc64 machines.

Anton
