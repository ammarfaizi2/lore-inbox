Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUA1M5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUA1M5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:57:24 -0500
Received: from chico.rediris.es ([130.206.1.3]:58287 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S265937AbUA1M5X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:57:23 -0500
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Tim Connors <tconnors+linuxkernel1075286311@astro.swin.edu.au>
Subject: Re: Cursor disappears on console, no frame-buffer
Date: Wed, 28 Jan 2004 13:56:51 +0100
User-Agent: KMail/1.5.4
References: <slrn-0.9.7.4-26788-30547-200401282138-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-26788-30547-200401282138-tc@hexane.ssi.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401281356.52102.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Miércoles, 28 de Enero de 2004 11:46, Tim Connors escribió:
> Recently, a few kernel revisions ago, I experimented with the
> frame-buffer. I don't know what I broke, but with nothing frame-buffer
> related in the kernel (It could have been broken for a long time, I
> don't use the console that much, but it certainly worked at one
> stage):

	Have you followed Dave's doc to console new style in 2.6?

http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt

	There you can find a lot of possible problems for an unexistent console.

	Regards,


		Ender.
- -- 
And need I remind you that I am naked in the snow...? I
 can't feel any of my extremities, and I mean *any* of them...
		-- Skinner (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAF7GUWs/EhA1iABsRAhAYAKDs9seX0Ag7AL6HHuFWCk/2anE2bgCgnotb
PsOLCNKnN2H/LjHifZ6X2Vw=
=G/Yq
-----END PGP SIGNATURE-----

