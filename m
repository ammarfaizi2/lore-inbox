Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSEMPLm>; Mon, 13 May 2002 11:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313947AbSEMPLl>; Mon, 13 May 2002 11:11:41 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:34310 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313925AbSEMPLl>; Mon, 13 May 2002 11:11:41 -0400
Date: Mon, 13 May 2002 17:11:21 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Greg KH <greg@kroah.com>
Cc: Marcus Alanen <maalanen@ra.abo.fi>, matthias.andree@gmx.de,
        riel@conectiva.com.br, Johnny Mnemonic <johnny@themnemonic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513151121.GA5811@louise.pinerecords.com>
In-Reply-To: <20020513120953.GD4258@louise.pinerecords.com> <Pine.LNX.4.44.0205131556550.23542-100000@tuxedo.abo.fi> <20020513140821.GB5134@louise.pinerecords.com> <20020513144519.GC5134@louise.pinerecords.com> <20020513140623.GA10453@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 20:52)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 13, 2002 at 04:45:19PM +0200, Tomas Szepe wrote:
>
> > > > Somebody make the mode changeable via command-line option...
> > > 
> > > Done... in a slightly different manner :)
> 
> What would be even _nicer_ is to remove the dependency on the changelog
> script entirely (right now you have to pipe the output through this perl
> script to get the results.)
> 
> The script that Linus (and others) uses can be found at:
> 	http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/

Hmm that could be done of course, but... why?
1) One more pipe can't hurt.
2) Linus himself requested a perl script that'd take the changelog as input.

T.
