Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbSKQAJs>; Sat, 16 Nov 2002 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbSKQAJs>; Sat, 16 Nov 2002 19:09:48 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45233 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267418AbSKQAJr>; Sat, 16 Nov 2002 19:09:47 -0500
Subject: Re: Why can't Johnny compile?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD6DE32.60503@kegel.com>
References: <3DD5D93F.8070505@kegel.com>
	<3DD5DC77.2010406@pobox.com>	<20021116151102.GI19015@higherplane.net>
	<3DD6B2C5.3010303@pobox.com>	<20021116213732.GO24641@conectiva.com.br>
	<20021116214250.GQ24641@conectiva.com.br>
	<1037490677.24843.7.camel@irongate.swansea.linux.org.uk> 
	<3DD6DE32.60503@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 00:43:29 +0000
Message-Id: <1037493809.24777.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 00:09, Dan Kegel wrote:
> * mark all drivers that don't compile OBSOLETE.  That keeps us from
>    trying to fix drivers without having hardware to test them.
>    Anyone with proper hardware is invited to fix the drivers and then
>    mark them non-OBSOLETE.

On which platform with which combination of options, which compiler ?  

Right now its not worth doing, but as we get closer to a release it
becomes worth marking some stuff as obsolete - not however by random
"compile tests" but by careful thought

