Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSEMPwP>; Mon, 13 May 2002 11:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314075AbSEMPwO>; Mon, 13 May 2002 11:52:14 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:48658 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314073AbSEMPwN>;
	Mon, 13 May 2002 11:52:13 -0400
Date: Mon, 13 May 2002 07:51:25 -0700
From: Greg KH <greg@kroah.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Marcus Alanen <maalanen@ra.abo.fi>, matthias.andree@gmx.de,
        riel@conectiva.com.br, Johnny Mnemonic <johnny@themnemonic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513145125.GG10675@kroah.com>
In-Reply-To: <20020513120953.GD4258@louise.pinerecords.com> <Pine.LNX.4.44.0205131556550.23542-100000@tuxedo.abo.fi> <20020513140821.GB5134@louise.pinerecords.com> <20020513144519.GC5134@louise.pinerecords.com> <20020513140623.GA10453@kroah.com> <20020513151121.GA5811@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Apr 2002 13:28:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 05:11:21PM +0200, Tomas Szepe wrote:
> > 
> > What would be even _nicer_ is to remove the dependency on the changelog
> > script entirely (right now you have to pipe the output through this perl
> > script to get the results.)
> > 
> > The script that Linus (and others) uses can be found at:
> > 	http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/
> 
> Hmm that could be done of course, but... why?
> 1) One more pipe can't hurt.
> 2) Linus himself requested a perl script that'd take the changelog as input.

Because we were throwing out things we wished the script could handle?
It's just a suggestion.  :)

thanks,

greg k-h
