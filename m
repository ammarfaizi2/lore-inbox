Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSAGCWv>; Sun, 6 Jan 2002 21:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289083AbSAGCWb>; Sun, 6 Jan 2002 21:22:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39688 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289081AbSAGCWV>;
	Sun, 6 Jan 2002 21:22:21 -0500
Date: Mon, 7 Jan 2002 00:22:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20020107022219.GB2686@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020107000736.04eb1c90@pop.cus.cam.ac.uk> <20020107012739.GB1920@conectiva.com.br> <E16NPGi-0001N0-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16NPGi-0001N0-00@starship.berlin>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 03:12:06AM +0100, Daniel Phillips escreveu:
> On January 7, 2002 02:27 am, Arnaldo Carvalho de Melo wrote:
> > When I did similar work for the network protocols, cleaning up
> > include/net/fs.h DaveM asked for benchmarks to see if the new approach,
    ^^^^^^^^^^^^^^^^
    include/net/sock.h

ouch, too much cleanups and lack of sleep(tm) 8)

- Arnaldo
