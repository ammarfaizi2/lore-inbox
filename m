Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbUALDsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 22:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbUALDsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 22:48:14 -0500
Received: from adsl-68-78-203-130.dsl.klmzmi.ameritech.net ([68.78.203.130]:23049
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S266092AbUALDsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 22:48:01 -0500
From: tabris <tabris@tabris.net>
To: "Stephen D. Williams" <sdw@lig.net>
Subject: Re: High Quality Random sources, was: Re: SecuriKey
Date: Sun, 11 Jan 2004 22:47:58 -0500
User-Agent: KMail/1.5.3
Cc: "Hunt, Adam" <ahunt@solvone.com>, linux-kernel@vger.kernel.org
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com> <4001ECBE.1020009@lig.net> <200401112238.32117.tabris@tabris.net>
In-Reply-To: <200401112238.32117.tabris@tabris.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401112247.59418.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 January 2004 10:38 pm, tabris wrote:
> On Sunday 11 January 2004 7:39 pm, Stephen D. Williams wrote:
> > Impossible?  I think not.  Some "mechanical" devices do exhibit true
> > random capability, especially when enhanced by algorithmic means.
> > To wit:  http://www.lavarand.org/
> >
> > Let me know if you can prove their methods don't provide a true "high
> > quality" random source.
> >
> > I'd like to see their code as a module with an automatic test to make
> > sure that the random source is high quality.  In this case, that
> > would mean making sure that the cap was not off the camera.
> >
> > sdw
>
> 	just because it passes tests of entropy and probability doesn't make
> it random. it just gets really really close. [hence pseudo-random]
> Everybody knows that /dev/random isn't truly random (it's still a state
> machine, dependent on a hash algorithm [chosen b/c they can take a
> non-random source and make it 'LOOK' random], and you feed it with data
> that is not totally predictable. BUT, there are still enough ways to
> exploit it if you can control/influence the input). it just can pass
> enough tests so that it can be used.
tere are devices such as this that I admit to not knowing of until now...
>
> 	and that still doesn't answer the question of how one would use [such
> a device] to 'generate a one time pad'. a one time pad must be
> possessed by both parties that are communicating. and if you have a
> secure channel to transmit an OTP, then you have one that can carry a
> message as well (most commonly, an OTP is used with a time delay. there
> is a single time when a secure channel is available. one [or both] of
> the parties brings it with him/her when he/she travels.
>
> 	so i'd believe that mebbe this Securikey could hold one... but, any
> USB key-fob type device can.
Perhaps I should make an amendment. you could perhaps put a geiger counter 
and cobalt or other radioactive source into a key fob... but i don't 
think it would ever be considered 'safe' to carry.

other sources may be available as well (i admit to not getting the time to 
read the website until just now). doesn't look like it fits in a USB 
key-fob yet tho.
>
> 	I'm sure that someone else can be more knowledgeable on this than I,
> but the general theory holds fast.

- -- 
If it's worth doing, it's worth doing for money.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAhju1U5ZaPMbKQcRAtDvAJoD1Jm/u3PlJ4EnUQXrPeUjLq14pQCfct9j
1zyYmroBRfkW37/ErNREEx8=
=UrEJ
-----END PGP SIGNATURE-----

