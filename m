Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTBTE2j>; Wed, 19 Feb 2003 23:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbTBTE2j>; Wed, 19 Feb 2003 23:28:39 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:3090 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264836AbTBTE2i>;
	Wed, 19 Feb 2003 23:28:38 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A33C@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (3/26) mach-pc
	9800
Date: Thu, 20 Feb 2003 13:38:36 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox
Sent: 2003/02/18 19:39
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (3/26)
mach-pc9800

> > +#ifdef CONFIG_NUMA
> > +#include <linux/mmzone.h>
> > +#include <asm/node.h>
> > +#include <asm/memblk.h>
> 
> Are there NUMA PC98 machines?
No. I'll remove it from next patch.

Thanks,
Osamu Tomita

