Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286490AbRLUAD4>; Thu, 20 Dec 2001 19:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286487AbRLUADd>; Thu, 20 Dec 2001 19:03:33 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:59652 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286484AbRLUADa>; Thu, 20 Dec 2001 19:03:30 -0500
Date: Thu, 20 Dec 2001 16:06:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Chris Ricker <kaboom@gatech.edu>
cc: Troels Walsted Hansen <troels@thule.no>,
        "'David S. Miller'" <davem@redhat.com>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: RE: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112201651370.26999-100000@verdande.oobleck.net>
Message-ID: <Pine.LNX.4.40.0112201606090.1622-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Chris Ricker wrote:

> On Thu, 20 Dec 2001, Troels Walsted Hansen wrote:
>
> > >From: David S. Miller
> > >   From: Linus Torvalds <torvalds@transmeta.com>
> > >   Well, that was true when the thing was written, but whether anybody
> > _uses_
> > >   it any more, I don't know. Tux gets the same effect on its own, and
> > I
> > >   don't know if Apache defaults to using sendfile or not.
> > >
> > >Samba uses it by default, that I know for sure :-)
> >
> > I wish... Neither Samba 2.2.2 nor the bleeding edge 3.0alpha11 includes
> > the word "sendfile" in the source at least. :( Wonder why the sendfile
> > patches where never merged...
>
> The only real-world source I've noticed actually using sendfile() are some
> of the better ftp daemons (such as vsftpd).

And XMail :)




- Davide


