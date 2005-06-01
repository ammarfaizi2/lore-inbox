Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFARF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFARF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVFARF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:05:58 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18344 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261472AbVFARFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:05:47 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 19:03:23 +0200
To: schilling@fokus.fraunhofer.de, dtor_core@ameritech.net
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DEA5B.nail7BFNJVI78@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
 <d120d500050531122879868bae@mail.gmail.com>
 <429DDA07.nail7BFA4XEC5@burner>
 <d120d50005060109051f9ade82@mail.gmail.com>
In-Reply-To: <d120d50005060109051f9ade82@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > 10 Years ago, Linux was completely unsuable with Linux /dev/sg* naming
> ^^^^^^^^^^^^^^^^^^
> > and mapping conventions. After I did develop an abstraction layer that
> > made Linux usable people could use stable dev= parameters across
> > reboots of Linux.
>
> Joerg, that is the problem. It was 10 years ago. USB was not existant,
> Firewire wasn't there, FC, etc. You could rely on your naming then.
> But it was last millenium, now dev= parameters are anything but
> stable. It just does not cut anymore, while using device node to
> specify device you want to work with is natural. And I am willing to
> bet if you give this oprion to users of other Unix-like OSes they
> would not complain either.

There is still no new and definitely stable interface that allows me to
asume that it makes sense to put effort in implementing support for it.

The natural way to access SCSI is the method I use, ASPI uses and FreeBSD
uses..... If Linux likes to implement things differntly, they are free
to do so but the Linux authors need to learn that I don't like to spend my
time on somethign that might be useless next week. Also note that the fact that
the Linux kernel by intention hides information I like to see from interfaces that 
the Linux kernel authors like me to use makes it obvious that there is
no mind on a useful cooperation with me.

For me it makes sense to wait until I see that this attitide did change.

I am still interested in cooperation, but this needs to be done in a way that
does not start with calling me a novice programmer....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
