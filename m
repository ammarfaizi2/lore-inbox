Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSH0W0C>; Tue, 27 Aug 2002 18:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSH0W0C>; Tue, 27 Aug 2002 18:26:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39923 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315485AbSH0W0B>; Tue, 27 Aug 2002 18:26:01 -0400
Subject: Re: [PATCH] XFree v4.2.x DRM/DRI Support for 2.4.20-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200208272247.26637.m.c.p@gmx.net>
References: <200208272247.26637.m.c.p@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 27 Aug 2002 23:32:21 +0100
Message-Id: <1030487541.7171.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-27 at 21:54, Marc-Christian Petersen wrote:
> Hi there,
> 
> this adds DRM/DRI Support for recent versions of XFree, f.e. v4.2.0 with a 
> slight modification. If you select SiS DRM Module, you also have to select 
> FrameBuffer SiS support otherwise it will result in unresolved symbols or 
> linking failure.

Marcelo if this is taken from the XFree86 code base don't apply it. The
XFree tree is horribly buggy compared to the backport from 2.4-ac

