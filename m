Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279800AbRJ0KHp>; Sat, 27 Oct 2001 06:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279801AbRJ0KHf>; Sat, 27 Oct 2001 06:07:35 -0400
Received: from stingr.net ([212.193.33.37]:35083 "HELO stingray.sgu.ru")
	by vger.kernel.org with SMTP id <S279800AbRJ0KHY>;
	Sat, 27 Oct 2001 06:07:24 -0400
Date: Sat, 27 Oct 2001 14:06:51 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
Message-ID: <20011027140650.K41175@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011026084328.A14814@bee.lk> <1004064922.21997.7.camel@Eleusis> <20011026090505.A15880@bee.lk> <20011026101313.A18310@bee.lk> <20011026145621.J41175@stingr.net> <20011027092802.A2651@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011027092802.A2651@bee.lk>; from anuradha@gnu.org on Sat, Oct 27, 2001 at 09:28:02AM +0600
User-Agent: Agent Orange
X-Mailer: mIRC32 v5.91 K.Mardam-Bey
X-RealName: Stingray Greatest Jr
Organization: Stingray Software
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Replying to Anuradha Ratnaweera:
> It is a linux based propiatory product, and we don't have control over it.

Then pay attention to other's posts and check thru your network.
Maybe some of devices connected to hub have full duplex on and kill the
whole (your) network (collision domain)

maybe it is router itself, maybe some of your users think they're smart and
'why don't use fd if my nic offer this feature'.

I've fought these idiots some time ago. But my network include switches and
if any idiot connected to hub wish to play with duplex - then he only play
with his own collision domain - not larger then single department.

and if it is not duplex issue, then take lan tester and test your cabling
... then hub ...
then get rid of your "proprietary linux based product"
:)

- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjvahzkACgkQyMW8naS07KQc1wCaA+V7mh80bIA8JEOCOtdvt5xn
PNYAoKQmotBJHdG1ri14yijbl6b7pgs8
=v/1K
-----END PGP SIGNATURE-----
