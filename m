Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJVNaf>; Tue, 22 Oct 2002 09:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJVNaf>; Tue, 22 Oct 2002 09:30:35 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:19328 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262528AbSJVNae>; Tue, 22 Oct 2002 09:30:34 -0400
Message-ID: <3DB55459.ACC5D447@cinet.co.jp>
Date: Tue, 22 Oct 2002 22:36:25 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
References: <20021021224919.A1509@precia.cinet.co.jp> <20021021175211.A642@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comment.

Ingo Oeser wrote:
> On Mon, Oct 21, 2002 at 10:49:19PM +0900, Osamu Tomita wrote:
> > This is a part of big patchset for support PC-9800
> > architecture, one of i386 sub architectures.
> 
> I'm courious, what the PC-9800 architecture is.
Please visit our web page. We put summary information there.
http://www.kmc.gr.jp/proj/linux98/index-english.html
PC-9800 has support hardware for japanese language, so in 80's 
many people use PC-9800 to run "Word processor" applications.
Recently, PC-9800 is mostly used as network client in enterprise,
goverment or school.

> > Core part cleanup has done. (But device drivers are still working.)
> > Many "#if" are killed by using "mach-xxx" framework.
> > If someone pick up this, we are very happy.
> > Comments are always welcome. Please tell me.
> 
> This patch is a good spring cleanup of arch/i386. You nicely
> replace many "magic hex values" with defines. That makes it very
> readable for other arch maintainers and even for the i386
> maintainers.
> 
> Good work!
Thanks, But other components need much more cleanup, sigh...

Best regards
Osamu Tomita  tomita@cinet.co.jp
