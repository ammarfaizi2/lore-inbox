Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbSKPVgE>; Sat, 16 Nov 2002 16:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbSKPVgD>; Sat, 16 Nov 2002 16:36:03 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13066 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267370AbSKPVgB>; Sat, 16 Nov 2002 16:36:01 -0500
Date: Sat, 16 Nov 2002 19:42:51 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116214250.GQ24641@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	john slee <indigoid@higherplane.net>, Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com> <20021116213732.GO24641@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116213732.GO24641@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 07:37:32PM -0200, Arnaldo C. Melo escreveu:
> Em Sat, Nov 16, 2002 at 04:04:05PM -0500, Jeff Garzik escreveu:
> > About the only thing WRT menuconfig I would be ok with is commenting out 
> > majorly broken drivers until they are fixed...
> 
> We have OBSOLETE, EXPERIMENTAL, why not BROKEN? 8)
> 
> It would appear as "BROKEN waiting for someone to fixme"

If, like for EXPERIMENTAL, BROKEN is selected by the user, or better,
by a developer wanting to fix what is broken.

- Arnaldo
