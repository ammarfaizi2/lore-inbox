Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHBQku>; Fri, 2 Aug 2002 12:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHBQkt>; Fri, 2 Aug 2002 12:40:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40444 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316070AbSHBQkp>; Fri, 2 Aug 2002 12:40:45 -0400
Subject: Re: [PATCH] 2.5.30 ARCH=i386 create dmi_scan.h and move decl from
	dmi_scan.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cranford <ac9410@attbi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D4A9E0E.A3B24096@attbi.com>
References: <3D4A9E0E.A3B24096@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 19:01:34 +0100
Message-Id: <1028311294.18309.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 15:58, Albert Cranford wrote:
> Hello Linus,
> Alan suggested that sensors group use a dmi scanner to
> manage allow/blacklist products.  In order to do this
> we need to use arch/i386/kernel/dmi_scan.c components.
> 
> Could you apply the following patch to facilitate this?
> Its been tested in linux-2.5.30 with no negative impact on
> kernel and may be useful for others.


Ok by me

