Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWHHUdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWHHUdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWHHUdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:33:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23769 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030294AbWHHUdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:33:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.18-rc3-mm2
Date: Tue, 8 Aug 2006 22:32:47 +0200
User-Agent: KMail/1.9.3
Cc: "Fabio Comolli" <fabio.comolli@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608081641.48621.rjw@sisk.pl> <d120d5000608081042i46eca97fvf1c3d67db65731b9@mail.gmail.com>
In-Reply-To: <d120d5000608081042i46eca97fvf1c3d67db65731b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608082232.47515.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 19:42, Dmitry Torokhov wrote:
> On 8/8/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 07 August 2006 21:00, Dmitry Torokhov wrote:
> > > On 8/7/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> > ]--snip--[
> > > >
> > > > Still interested in dmesg with i8042.debug=1 ?
> > > >
> > >
> > > Yes, _with_ the i8042 polling patch applied.
> >
> > I've got one for you (attached).
> >
> 
> Thnk you, I think I see what the problem is. Rafael, could you please
> try booting with i8042.nomux and tell me if mouse starts working.

It's a touchpad, but I guess that doesn't make a difference?

Rafael
