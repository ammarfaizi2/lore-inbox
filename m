Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSHaQie>; Sat, 31 Aug 2002 12:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSHaQie>; Sat, 31 Aug 2002 12:38:34 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:5364 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317628AbSHaQib>; Sat, 31 Aug 2002 12:38:31 -0400
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
In-Reply-To: <E17lArx-0004PK-00@starship>
References: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
	<1030755064.1225.18.camel@irongate.swansea.linux.org.uk> 
	<E17lArx-0004PK-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 17:43:05 +0100
Message-Id: <1030812185.3490.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 17:13, Daniel Phillips wrote:
> Why worry about what SELinux needs, since it is proprietary, and may
> not even be legal to distribute?  Perhaps there is some other set of
> security plugins that actually matter.

SELinux is GPL. Americans may not be allowed to use it but that doesn't
make it proprietary. As it happens there are several very plausible ways
of working around the bogus patents anyway

