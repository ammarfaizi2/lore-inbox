Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136584AbREIQVa>; Wed, 9 May 2001 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREIQVU>; Wed, 9 May 2001 12:21:20 -0400
Received: from adsl-64-123-58-70.dsl.stlsmo.swbell.net ([64.123.58.70]:21747
	"EHLO bigandy.swbell.net") by vger.kernel.org with ESMTP
	id <S136582AbREIQVL>; Wed, 9 May 2001 12:21:11 -0400
Date: Wed, 9 May 2001 11:21:04 -0500 (CDT)
From: Andy Carlson <naclos@swbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xUbS-0002Op-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0105091120020.1755-100000@bigandy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mine is a Micronics W6LI with Phoenix BIOS.

Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

On Wed, 9 May 2001, Alan Cox wrote:

> > This has been reported to both Mandrake and Redhat:
> > 
> > http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=29555
> > 
> > I've been trying to find out if there's a fix (if it's aic7xxx 6.1.13
> > that's great!), but Redhat seem to believe it's a 2.4 kernel PCI bug:
> 
> Personally I still think its a BIOS bug in those Intel BIOS boards. Hopefully
> some of the VA folks will eventually have time to double check the BIOS
> $PIRQ routing table on these systems and verify if the kernel is parsing it
> wrong or if its wrong in the BIOS ROM
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

