Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266963AbSISMXF>; Thu, 19 Sep 2002 08:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSISMXF>; Thu, 19 Sep 2002 08:23:05 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:38098 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S266963AbSISMXE>;
	Thu, 19 Sep 2002 08:23:04 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
References: <3D891BD1.8F774946@digeo.com>
	<m3bs6uyerj.fsf_-_@lapper.ihatent.com>
	<1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
	<20020918.183354.50766403.davem@redhat.com>
	<1032432315.26712.18.camel@irongate.swansea.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Sep 2002 14:27:51 +0200
In-Reply-To: <1032432315.26712.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3bs6uw4e0.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Thu, 2002-09-19 at 02:33, David S. Miller wrote:
> > /home/davem/src/BK/marcelo-2.4/include/asm-i386
> > ? egrep TIOCM_MODEM_BITS *.h
> > ? cd ../../drivers/net/irda
> > ? egrep TIOCM_MODEM_BITS *.c
> > irtty.c:        int arg = TIOCM_MODEM_BITS;
> 
> He said pre7-ac2. I know pre7 is broken, I broke it  8(
> 

Then we all agree, -pre7 is broken and -pre7-ac2 works. :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
