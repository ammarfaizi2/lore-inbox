Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbSI0Tz4>; Fri, 27 Sep 2002 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSI0Tzz>; Fri, 27 Sep 2002 15:55:55 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:7416 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262630AbSI0Tzv>; Fri, 27 Sep 2002 15:55:51 -0400
Subject: Re: [PATCH] fix drm ioctl ABI default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: Christoph Hellwig <hch@sgi.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020927191316.GA564@phunnypharm.org>
References: <20020927212752.E4733@sgi.com>
	<1033153674.16726.10.camel@irongate.swansea.linux.org.uk> 
	<20020927191316.GA564@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 21:06:06 +0100
Message-Id: <1033157166.16758.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 20:13, Ben Collins wrote:
> > o Has security holes that are fixed in 4.2.1 only
> 
> ...or patched onto 4.1.x from 4.2 source.

I'd hope from 4.2.1 source plus the later errata fix but yes this is a
good point. Its not an assumption we can reasonably make

I think Cristoph wins 

