Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSAAGQU>; Tue, 1 Jan 2002 01:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287763AbSAAGQB>; Tue, 1 Jan 2002 01:16:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:60174 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287760AbSAAGPw>;
	Tue, 1 Jan 2002 01:15:52 -0500
Date: Tue, 1 Jan 2002 04:15:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bill Nottingham <notting@redhat.com>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20020101041553.A10400@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bill Nottingham <notting@redhat.com>,
	James Simmons <jsimmons@transvirtual.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011231195655.A16870@conectiva.com.br> <Pine.LNX.4.10.10112311425020.12522-100000@www.transvirtual.com> <20011231203112.A16975@conectiva.com.br> <20011231214322.A26481@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231214322.A26481@nostromo.devel.redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 31, 2001 at 09:43:22PM -0500, Bill Nottingham escreveu:
> Arnaldo Carvalho de Melo (acme@conectiva.com.br) said: 
> > My card is a Neomagic, so I use vesafb...
> > 
> > Please let me know if somebody has specs for:
> > 
> > 00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
> > 128XD] (rev 01)
> 
> Someone wrote a neomagic framebuffer driver at some point; ISTR
> the patch showing up on linux-kernel. Mind you, I don't know that
> it was accelerated at all...

Indeed, I've found it at
http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.0/0658.html

and it seems to be accelerated, will test tomorrow and post the results.

Should be interesting to use konqueror/qt on a framebuffer console...

- Arnaldo
