Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267398AbSKPXRi>; Sat, 16 Nov 2002 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbSKPXRi>; Sat, 16 Nov 2002 18:17:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22193 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267398AbSKPXRi>; Sat, 16 Nov 2002 18:17:38 -0500
Subject: Re: Why can't Johnny compile?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021116214250.GQ24641@conectiva.com.br>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com>
	<20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com>
	<20021116213732.GO24641@conectiva.com.br> 
	<20021116214250.GQ24641@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 23:51:17 +0000
Message-Id: <1037490677.24843.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 21:42, Arnaldo Carvalho de Melo wrote:
> Em Sat, Nov 16, 2002 at 07:37:32PM -0200, Arnaldo C. Melo escreveu:
> > Em Sat, Nov 16, 2002 at 04:04:05PM -0500, Jeff Garzik escreveu:
> > > About the only thing WRT menuconfig I would be ok with is commenting out 
> > > majorly broken drivers until they are fixed...
> > 
> > We have OBSOLETE, EXPERIMENTAL, why not BROKEN? 8)
> > 
> > It would appear as "BROKEN waiting for someone to fixme"
> 
> If, like for EXPERIMENTAL, BROKEN is selected by the user, or better,
> by a developer wanting to fix what is broken.

Thats basically what "OBSOLETE" is

