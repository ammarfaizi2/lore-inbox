Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbREaT5a>; Thu, 31 May 2001 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbREaT5U>; Thu, 31 May 2001 15:57:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65528 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263201AbREaT5R> convert rfc822-to-8bit;
	Thu, 31 May 2001 15:57:17 -0400
Date: Thu, 31 May 2001 15:57:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
In-Reply-To: <3B16A01C.ED5C6CCB@redhat.com>
Message-ID: <Pine.GSO.4.21.0105311555250.17748-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 May 2001, Arjan van de Ven wrote:

> José Luis Domingo López wrote:
> > 
> > On Thursday, 31 May 2001, at 13:24:54 -0400,
> > Eric S. Raymond wrote:
> > 
> > > It gives me great pleasure to announce that the Configure.help master
> > > file is now complete with respect to 2.4.5.  Every single one of the
> > > 2699 configuration symbols actually used in the 2.4.5 codebase's C
> > > source files or Makefiles now has an entry in Configure.help.
> > >
> > Would it be great to have a similar documentation for those hundreds of
> > "files" under /proc ?. Something like:
> 
> <snip>
> Powertweak has descriptions for most of the usable /proc entries,
> in XML format but the descriptions are easily extractable. Maybe it's 
> a good idea to make the powertweak set complete instead / share the set
> with the kernel docs.

We should start removing the crap from procfs in 2.5. Documenting shit is
a good step, but taking it out would be better.

