Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRBOC3y>; Wed, 14 Feb 2001 21:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRBOC3p>; Wed, 14 Feb 2001 21:29:45 -0500
Received: from feral.com ([192.67.166.1]:45411 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S131587AbRBOC3a>;
	Wed, 14 Feb 2001 21:29:30 -0500
Date: Wed, 14 Feb 2001 18:28:32 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Chip Salzenberg <chip@valinux.com>
cc: Wakko Warner <wakko@animx.eu.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx (and sym53c8xx) plans
In-Reply-To: <20010214182006.B21511@valinux.com>
Message-ID: <Pine.LNX.4.21.0102141827400.22737-100000@zeppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Chip Salzenberg wrote:

> According to Matthew Jacob:
> > See http://www.freebsd.org/~gibbs/linux.
> 
> Here at VA we're already using Jason's driver -- it works on the Intel
> STL2 motherboard, while Doug's driver doesn't (or didn't, a month ago).

"Justin" not "Jason"

> 
> While we're discussing SCSI drivers, I'd also like to put in a good
> word for the Sym-2 Symbios/NCR drivers from Gerard Roudier:
> 
>     ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/
> 
> Joe-Bob says: "Check it out."

Yes indeed. And he also support FreeBSD too. Very excellent.

Maybe the two of *them* can convince Linus to take the !$*!)$*!)$*~$)* patch
to scsi_syms.c that exports the add/del timer functions....


