Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbULUNPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbULUNPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbULUNPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:15:41 -0500
Received: from gate.adanco.com ([212.25.16.151]:22029 "EHLO johnny.adanco.com")
	by vger.kernel.org with ESMTP id S261753AbULUNPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:15:23 -0500
From: Adrian von Bidder <avbidder@fortytwo.ch>
To: linux-kernel@vger.kernel.org, linux lover <linux.lover2004@gmail.com>
Subject: Re: how to solve kernel oops message
Date: Tue, 21 Dec 2004 14:15:17 +0100
User-Agent: KMail/1.7.1
Cc: kernelnewbies@nl.linux.org
References: <72c6e37904122101137698b6a1@mail.gmail.com>
In-Reply-To: <72c6e37904122101137698b6a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart55201089.GQEJr9uoiD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412211415.22276@fortytwo.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart55201089.GQEJr9uoiD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 December 2004 10.13, linux lover wrote:
> Hi all,
>             I need urgent help on kernel oops message. Can anybody
[..]

This information is next to useless. At least report
 - what did you do that caused the oops message?
 - what kernel version, exactly, are you using
   - can you reproduce it with other (newer) kernel versions, too?
   - can you reproduce it on other machines, too?
 - how does your kernel configuration look like?

(btw, your previous message about loading a module makes me wonder if you=20
understand enough of Linux to understand what people here might propose=20
that you do to solve the problem.  There are are many places where people=20
who are new to Linux can request help, but the kernel mailing list is=20
probably not one of those...)

greetings
=2D- vbi


=2D-=20
Beware of the FUD - know your enemies. This week
    * The Alexis de Toqueville Institue *
http://fortytwo.ch/opinion/adti

--nextPart55201089.GQEJr9uoiD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: get my key from http://fortytwo.ch/gpg/92082481

iKcEABECAGcFAkHIIepgGmh0dHA6Ly9mb3J0eXR3by5jaC9sZWdhbC9ncGcvZW1h
aWwuMjAwMjA4MjI/dmVyc2lvbj0xLjUmbWQ1c3VtPTVkZmY4NjhkMTE4NDMyNzYw
NzFiMjVlYjcwMDZkYTNlAAoJECqqZti935l6aIQAniw291nfP3UK+VOf7nSBYsjy
CTJ0AJ9CcuCVaS2+RnMO37NFzuovzC52LQ==
=mhAq
-----END PGP SIGNATURE-----

--nextPart55201089.GQEJr9uoiD--
