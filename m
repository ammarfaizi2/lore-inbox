Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbRFPVuw>; Sat, 16 Jun 2001 17:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbRFPVum>; Sat, 16 Jun 2001 17:50:42 -0400
Received: from 1-084.ctame701-2.telepar.net.br ([200.181.138.84]:1782 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S264665AbRFPVua>; Sat, 16 Jun 2001 17:50:30 -0400
Date: Sat, 16 Jun 2001 18:14:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Thiago Vinhas de Moraes <tvlists@networx.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
Message-ID: <20010616181431.B1058@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Thiago Vinhas de Moraes <tvlists@networx.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E15B0vv-000780-00@the-village.bc.nu> <200106172246.SAA00859@olimpo.networx.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200106172246.SAA00859@olimpo.networx.com.br>; from tvlists@networx.com.br on Sat, Jun 16, 2001 at 05:56:08PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 16, 2001 at 05:56:08PM -0300, Thiago Vinhas de Moraes escreveu:
> Em Sex 15 Jun 2001 18:15, Alan Cox escreveu:
> > > Why the 2.4.5-ac series doesn't have merges from Linus 2.4.6-pre anymore?
> >
> > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> > enough to merge. I'm letting someone else be the sucide squad.. so far it
> > looks like it is indeed fine but I want to wait and see more yet
> 
> But wouldn't be safe/possible/viable to merge 2.4.6-pre partially, excluding 
> the page cache stuff for the moment?
> IMHO, the 2.4.6-pre has important improvements, and it would be difficult to 
> merge to it later.
> Just a stupid opinion. No offenses.

If you look closely, some of the good things in 2.4.6-pre3 were backported
by Marcelo and included in 2.4.5-ac15

- Arnaldo
