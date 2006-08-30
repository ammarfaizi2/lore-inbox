Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWH3I5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWH3I5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWH3I5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:57:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:44991 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750743AbWH3I5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:57:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Patrizio Bassi" <patrizio.bassi@gmail.com>
Subject: Re: [BUG?] 2.6.17.x suspend problems
Date: Wed, 30 Aug 2006 11:01:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@ucw.cz>
References: <742b1fb30608280446x2b0cf2d4p5aae2bb66ba41555@mail.gmail.com> <742b1fb30608290414w5d7efc2et349f5ca32f241834@mail.gmail.com> <742b1fb30608292358y6cebdf4eg654d7a1973a91c3@mail.gmail.com>
In-Reply-To: <742b1fb30608292358y6cebdf4eg654d7a1973a91c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301101.01816.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 08:58, Patrizio Bassi wrote:
> 2006/8/29, Patrizio Bassi <patrizio.bassi@gmail.com>:
> > 2006/8/29, Rafael J. Wysocki <rjw@sisk.pl>:
> > > On Monday 28 August 2006 13:46, Patrizio Bassi wrote:
> > > > when i try to suspend my notebook i have problems with ide controller.
> > > > the copy lasts a lot and i get oops.
> > >
> > > I haven't seen any patches related to SIS chipsets recently.
> > >
> > > There is a chance the latest -mm will work, so you can try it (no warranty,
> > > though).  If not, please file a bug report at http://bugzilla.kernel.org
> > > (with a Cc to rjwysocki@sisk.pl).
> >
> >
> > do you mean the .18-mm sources i guess, not the .17 ones.
> >
> > Ok, i'll try as soon as possibile.

]--snip--[
> i just tested 2.6.18-rc4-mm3.
> 
> as soon as i ask for suspending i get a black screen.
> waiting for lots of time...something like 1 min i see:
> 
> Disabling Interrupt #14
> and after, even waiting some means...nothing more.

Please file a report at http://bugzilla.kernel.org like I said previously.

I'm afraid there's no quick fix for you right now.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
