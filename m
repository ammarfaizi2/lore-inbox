Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVKGQYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVKGQYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKGQYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:24:44 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:20945 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S964838AbVKGQYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:24:43 -0500
Date: Mon, 7 Nov 2005 11:24:43 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Jerome Glisse <j.glisse@gmail.com>
cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: 3D video card recommendations
In-Reply-To: <4240b9160511070750t25fab9e2u3c8e2c1414b55ebf@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0511071120540.2132@innerfire.net>
References: <1131112605.14381.34.camel@localhost.localdomain> 
 <1131349343.2858.11.camel@laptopd505.fenrus.org> 
 <1131367371.14381.91.camel@localhost.localdomain>  <20051107125513.GD3726@localhost.localdomain>
  <pan.2005.11.07.14.50.56.126577@sci.fi> <4240b9160511070750t25fab9e2u3c8e2c1414b55ebf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658635175-1533924563-1131380683=:2132"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658635175-1533924563-1131380683=:2132
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Nov 2005, Jerome Glisse wrote:
> On 11/7/05, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> > On Mon, 07 Nov 2005 12:55:13 +0000, Hugo Mills wrote:
> >
> > > On Mon, Nov 07, 2005 at 07:42:51AM -0500, Steven Rostedt wrote:
> > >> On Mon, 2005-11-07 at 08:42 +0100, Arjan van de Ven wrote:
> > >>
> > >> > people who buy a 3D card for linux that depends on a closed source
> > >> > module take a few risks, and they should be aware of them (I suspe=
ct
> > >> > they are) so let me make some of them explicit:
> > >>
> > >> Are there good 3D cards that don't depend on a proprietary module, t=
hat
> > >> can run on a AMD64 board?  That was pretty much my questing to begin
> > >> with :)
> > >
> > >    http://www.xgitech.com/
> > >
> > >    Not the fastest pieces of hardware out there by some way, but they
> > > _do_ have open-source drivers.
> >
> > That's not entirely true. The DRI driver is closed source.
> >
>=20
> DRI closed source ? You mean the fglrx driver from ati ?
>=20
> Anyway my advice would be to look at dri project an
> see the supported card list. http://dri.freedesktop.org
> if you want a card with open source 3d driver.
>=20
> ATI & Intel graphics chipset seems to have the best
> open source support i am aware of. For ATI the r300/r400
> (radeon 9500-9800/ X300-X800) support is still
> experimental (IIRC there are PCI-E issues).
>=20
> best,
> Jerome Glisse

FGLRX won't function at all with 2.6.14 and requires patching to work with=
=20
2.6.13.

And your right there are PCI-E issues.. the cards work but no direct=20
rendering is supported although I did see some patches head to Linus that=
=20
fix that. (waiting for the next pre release so mine will work.. I should=20
really sit down and learn GIT) =20

=09Gerhard
=20

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
--658635175-1533924563-1131380683=:2132--
