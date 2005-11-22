Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVKVFRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVKVFRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKVFRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:17:15 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:46994
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932253AbVKVFRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:17:15 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Mon, 21 Nov 2005 23:17:01 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511211253.40212.rob@landley.net> <20051121192431.GJ29518@elf.ucw.cz>
In-Reply-To: <20051121192431.GJ29518@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212317.01589.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 13:24, Pavel Machek wrote:
> Hi!
> > > I probably miss-patched my kernel, sorry. Not sure what you have to do
> > > to change permissions, probably mail it to akpm and ask him to add +x
> > >
> > > :-).
> >
> > I'm hoping to get an ack from the kconfig guys first, hence the cc:
> >
> > But does it work ok for you?
>
> I was not even able to patch it properly :-(. Version against current
> -git would be handy.

It still applied cleanly to 2.6.15-rc2-git1, which is the most recent version 
I currently know how to squeeze out of the web interface.  What tree are you 
attempting to apply it to?

Rob
