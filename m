Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbUA1NIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265936AbUA1NIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:08:41 -0500
Received: from chico.rediris.es ([130.206.1.3]:2238 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S265933AbUA1NIj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:08:39 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Greg KH <greg@kroah.com>
Subject: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Date: Wed, 28 Jan 2004 14:08:34 +0100
User-Agent: KMail/1.5.4
References: <10752464532256@kroah.com>
In-Reply-To: <10752464532256@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401281408.34364.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Miércoles, 28 de Enero de 2004 00:34, Greg KH escribió:
> +			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
> +				" Defaulting to LM85.\n", verstep);

	Hello, Greg.

	Just noticed, please s,recgonized,recognized,g all over the file.

	Thanks,


		Ender.
- -- 
Oh, I saw...Very American. Fire enough bullets and hope
 they hit the target!
		-- Allan Quatermain (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAF7RSWs/EhA1iABsRAhEvAJ9lEYqh0EkDsDqH12qEcWNRNrUJbACg6zdm
O+T6J0IG3C98iwMhZjh3p8c=
=jtJ1
-----END PGP SIGNATURE-----

