Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281046AbRKZNMO>; Mon, 26 Nov 2001 08:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKZNME>; Mon, 26 Nov 2001 08:12:04 -0500
Received: from [195.66.192.167] ([195.66.192.167]:43269 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281046AbRKZNL5>; Mon, 26 Nov 2001 08:11:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.16-pre1
Date: Mon, 26 Nov 2001 15:07:06 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01112615070600.00943@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 November 2001 16:39, Marcelo Tosatti wrote:
> Hi,
>
> So here it goes 2.4.16-pre1. Obviously the most important fix is the
> iput() one, which probably fixes the filesystem corruption problem people
> have been seeing.

This is quite annoying to have non-pre kernels with simple bugs like 
recent loop device bug etc.

Maybe this can be prevented by adopting a rule that non-pre kernel is made
from last pre/ac/... which was good enough by changing version # _only_,
without even single buglet squashing?

This way we will not disappoint those people who download non-pres in hope
they are more stable.

Just my 2 cents. 
--
vda
