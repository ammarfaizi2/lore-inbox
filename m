Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJ0FVt>; Sun, 27 Oct 2002 01:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSJ0FVt>; Sun, 27 Oct 2002 01:21:49 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:6669 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262276AbSJ0FVs>; Sun, 27 Oct 2002 01:21:48 -0400
Date: Sun, 27 Oct 2002 01:10:39 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [BUG] 2.5.44 : /proc/net/arp broken
Message-ID: <20021027041039.GC2485@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	davem@redhat.com
References: <wrphefd5te3.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrphefd5te3.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 23, 2002 at 12:41:56PM +0200, Marc Zyngier escreveu:
> Hi all,
> 
> I just hit a nice little bug : cat /proc/net/arp crashes easily my two
> test systems running 2.5.44 (a 486 and a P266, if that matters...).

I'm back from a business trip, so tomorrow I'll have time to fix this,
thanks for the report.

- Arnaldo
