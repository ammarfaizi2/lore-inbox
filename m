Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287038AbSABWXy>; Wed, 2 Jan 2002 17:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSABWXq>; Wed, 2 Jan 2002 17:23:46 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:58885 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S287045AbSABWXh>; Wed, 2 Jan 2002 17:23:37 -0500
Message-Id: <200201022223.g02MNXh25982@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: David Golden <david.golden@oceanfree.net>, linux-kernel@vger.kernel.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 16:21:01 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <3C337AC8.2020900@free.fr> <02010222155300.11915@golden1.goldens.ie>
In-Reply-To: <02010222155300.11915@golden1.goldens.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 16:15, David Golden wrote:
> On Wednesday 02 January 2002 21:25, Lionel Bouton wrote:
> it and
>
> > search it in numerous places : with or without `-uname -r` appended (at
> > least in / /boot /usr/src/linux).
> >
> :-( Pity it apparently doesn't search
>
> /boot/`uname -r`/System.map
>
> That way the /boot/kernelver/* scheme (see previous post) would work...

That would be nice.  I used to have my own personal system and hacked version 
of klogd that had a /boot/kernels directory, but in it I still maintained the 
old (cumbersum) naming convention.  I *like* this idea.  A lot.

/boot/`uname -r`/{System.map,bzImage,.config}

So, what's it take to make it a "standard"?

-Nick
