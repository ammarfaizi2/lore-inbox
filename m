Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267369AbSKPVas>; Sat, 16 Nov 2002 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbSKPVar>; Sat, 16 Nov 2002 16:30:47 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:9994 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267369AbSKPVar>; Sat, 16 Nov 2002 16:30:47 -0500
Date: Sat, 16 Nov 2002 19:37:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: john slee <indigoid@higherplane.net>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116213732.GO24641@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	john slee <indigoid@higherplane.net>, Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD6B2C5.3010303@pobox.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 04:04:05PM -0500, Jeff Garzik escreveu:
> john slee wrote:
> >#error or #warning) to tag things as known broken.  currently people use
> >#error during compile, but i'd like to see it show up in menuconfig
> >somehow.
 
> I respectfully disagree...  I think if these sort of FIXMEs show up in 
> menuconfig, you're not only cluttering up menuconfig, you also moving 
> past the level of programmer to the sysadmin/power-user level.  That 
> seems like it would generate more bug reports than useful work.
 
> About the only thing WRT menuconfig I would be ok with is commenting out 
> majorly broken drivers until they are fixed...

We have OBSOLETE, EXPERIMENTAL, why not BROKEN? 8)

It would appear as "BROKEN waiting for someone to fixme"

- Arnaldo
