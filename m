Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290721AbSARPRj>; Fri, 18 Jan 2002 10:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSARPRa>; Fri, 18 Jan 2002 10:17:30 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:31238 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290721AbSARPRS>;
	Fri, 18 Jan 2002 10:17:18 -0500
Date: Fri, 18 Jan 2002 13:17:16 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        boissiere@mediaone.net (Guillaume Boissiere),
        linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020118151716.GB7976@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	boissiere@mediaone.net (Guillaume Boissiere),
	linux-kernel@vger.kernel.org
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <E16RW8L-0006WP-00@the-village.bc.nu> <20020118150951.GA7976@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020118150951.GA7976@conectiva.com.br>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 18, 2002 at 01:09:51PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 18, 2002 at 10:20:29AM +0000, Alan Cox escreveu:
> > You seem to be short
> > 
> > NetBEUI network stack			Arnaldo Carvalho de Melo (from
> > 					Procom donated code)
> 
> Right, the 802.2 code as well

Also please put the 802.2 stack in another line because Jay Schullist is
working with me in this and has contributed the support for PF_LLC sockets,
as the procom code had 802.2 available only for higher level protocols,
with Jay's work it is now possible to use 802.2 sockets from userspace.

- Arnaldo
