Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSEMPHN>; Mon, 13 May 2002 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSEMPHM>; Mon, 13 May 2002 11:07:12 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:37394 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313217AbSEMPHL>;
	Mon, 13 May 2002 11:07:11 -0400
Date: Mon, 13 May 2002 07:06:23 -0700
From: Greg KH <greg@kroah.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Marcus Alanen <maalanen@ra.abo.fi>, matthias.andree@gmx.de,
        riel@conectiva.com.br, Johnny Mnemonic <johnny@themnemonic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513140623.GA10453@kroah.com>
In-Reply-To: <20020513120953.GD4258@louise.pinerecords.com> <Pine.LNX.4.44.0205131556550.23542-100000@tuxedo.abo.fi> <20020513140821.GB5134@louise.pinerecords.com> <20020513144519.GC5134@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Apr 2002 12:43:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 04:45:19PM +0200, Tomas Szepe wrote:
> > > Somebody make the mode changeable via command-line option...
> > 
> > Done... in a slightly different manner :)

What would be even _nicer_ is to remove the dependency on the changelog
script entirely (right now you have to pipe the output through this perl
script to get the results.)

The script that Linus (and others) uses can be found at:
	http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/

thanks,

greg k-h
