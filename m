Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286288AbRLTX4N>; Thu, 20 Dec 2001 18:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286480AbRLTX4E>; Thu, 20 Dec 2001 18:56:04 -0500
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:35237 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S286476AbRLTXz5>;
	Thu, 20 Dec 2001 18:55:57 -0500
Date: Thu, 20 Dec 2001 16:55:55 -0700 (MST)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: Troels Walsted Hansen <troels@thule.no>
Cc: "'David S. Miller'" <davem@redhat.com>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: RE: Scheduler ( was: Just a second ) ...
In-Reply-To: <007401c189a7$50f6cd60$0300000a@samurai>
Message-ID: <Pine.LNX.4.33.0112201651370.26999-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Troels Walsted Hansen wrote:

> >From: David S. Miller
> >   From: Linus Torvalds <torvalds@transmeta.com>
> >   Well, that was true when the thing was written, but whether anybody
> _uses_
> >   it any more, I don't know. Tux gets the same effect on its own, and
> I
> >   don't know if Apache defaults to using sendfile or not.
> >   
> >Samba uses it by default, that I know for sure :-)
> 
> I wish... Neither Samba 2.2.2 nor the bleeding edge 3.0alpha11 includes
> the word "sendfile" in the source at least. :( Wonder why the sendfile
> patches where never merged...

The only real-world source I've noticed actually using sendfile() are some
of the better ftp daemons (such as vsftpd).

later,
chris

-- 
Chris Ricker                                               kaboom@gatech.edu

This is a dare to the Bush administration.
        -- Thurston Moore


