Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSJVCwz>; Mon, 21 Oct 2002 22:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSJVCwz>; Mon, 21 Oct 2002 22:52:55 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:64266 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262084AbSJVCwy>; Mon, 21 Oct 2002 22:52:54 -0400
Date: Mon, 21 Oct 2002 23:58:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: landley@trommello.org, Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Message-ID: <20021022025806.GA27943@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>, landley@trommello.org,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com> <200210211642.10435.landley@trommello.org> <3DB4BD8F.1010707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB4BD8F.1010707@pobox.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2002 at 10:53:03PM -0400, Jeff Garzik escreveu:
> >Okay, ARE the Usagi IPV6 patches and Dave's work dovetailing into one 
> >project?  I'll happily collate them if so, I'd just like to hear it from 
> >one of the principal authors...

> I'm sure he can elaborate, but AFAIK DaveM and Alexey are only doing 
> IPSEC... where USAGI and IPSEC intersect, there will be clashes.  So if 
> USAGI is waiting on IPSEC to submit more patches, things are waiting on 
> DaveM.  But if there are IPSEC-independent patches, USAGI should go 
> ahead and send them :)

They are sending it, and David already stated here that he will be using some
pieces of USAGI's ipsec work, but the core is being coded by him and Alexey.

- Arnaldo
