Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRI3BRH>; Sat, 29 Sep 2001 21:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRI3BQ5>; Sat, 29 Sep 2001 21:16:57 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:28396 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272244AbRI3BQq>; Sat, 29 Sep 2001 21:16:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [PATCH] Linux 0.01 disk lockup - read the old (1991) archives.
Date: Sat, 29 Sep 2001 17:16:36 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010927175126.12043B-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1010927175126.12043B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Message-Id: <01092917163603.01422@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 September 2001 12:08, Mikulas Patocka wrote:
> > > Linux 0.01 has a bug in disk request sorting - when interrupt happens
> > > while sorting is active, the interrupt routine won't clear do_hd - thus
> > > the disk will stay locked up forever.
> >
> > Ehh..
> >
> > Mikulas, do you want to be the official maintainer for the 0.01.xxx
> > series?
> >
> > Note that much of the maintenance work is probably just to reproduce and
> > make all the user-level etc infrastructure available..
>
> It would be cool to have linux-0.01 distribution. I started to use linux
> in 2.0 times, so I'm probably not the right person to maintain it. I don't
> even know where to get programs for it and I doubt it would work on my 4G
> disk.
>
> Mikulas

You might want to read the mailing list entries from 1991 and early 1992:

http://www.kclug.org/old_archives/linux-activists/

I've put together a summary of some of the more interesting early posts from 
1991 and early 1992 for the computer history book I'm writing...

http://penguicon.sourceforge.net/comphist/1991.html

http://penguicon.sourceforge.net/comphist/1992.html

Rob
