Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSEYM3Y>; Sat, 25 May 2002 08:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSEYM3X>; Sat, 25 May 2002 08:29:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2802 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314504AbSEYM3X>; Sat, 25 May 2002 08:29:23 -0400
Subject: Re: RTAI/RtLinux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erwin Rol <erwin@muffin.org>
Cc: linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
In-Reply-To: <1022317532.15111.155.camel@rawpower>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 May 2002 14:30:53 +0100
Message-Id: <1022333453.11811.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 10:05, Erwin Rol wrote:
> I just hope the linux developers are smart enough to not accept the
> RTLinux into the main kernel, cause someday someone might come up with
> the idea to write something that allows to have userspace programs to be
> hard-realtime, and than you have to stop allowing non GPL userspace
> programs, like for example GLIB( which is LGPL). 

LGPL can be used as GPL. If you haven't even read the license do that
before the flamewar please.

The RtLinux patent seems to boil down to "If you are free software we
are free software, if you are proprietary we play in your space too,
please pay up". Its not something I'm totally happy with but I don't
really see how else Victor can phrase it.

