Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSKOLuP>; Fri, 15 Nov 2002 06:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSKOLuP>; Fri, 15 Nov 2002 06:50:15 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:3599 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265275AbSKOLuO>; Fri, 15 Nov 2002 06:50:14 -0500
Date: Fri, 15 Nov 2002 09:57:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115115701.GP18180@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021115081044.GI18180@conectiva.com.br> <20021115115402.GB25902@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115115402.GB25902@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 15, 2002 at 12:54:02PM +0100, Pavel Machek escreveu:
> > So perhaps the following patch is in order? Its kind of brute force, disabling it
> > altogether, but it at least fixes it for now.
> 
> Please don't, better patch is pending to fix that.

wli told me, going to use shrink_all_memory(), etc

- Arnaldo
