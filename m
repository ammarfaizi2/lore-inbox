Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319212AbSHNF3B>; Wed, 14 Aug 2002 01:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319213AbSHNF3B>; Wed, 14 Aug 2002 01:29:01 -0400
Received: from [216.38.156.94] ([216.38.156.94]:44303 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S319212AbSHNF3A>; Wed, 14 Aug 2002 01:29:00 -0400
Date: Tue, 13 Aug 2002 22:32:50 -0700
From: Dmitri <dmitri@users.sourceforge.net>
To: Ashok Raj <ashokr2@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XIRCOM usb->serial converter
Message-ID: <20020814053250.GC30425@usb.networkfab.com>
Mail-Followup-To: Ashok Raj <ashokr2@attbi.com>,
	linux-kernel@vger.kernel.org
References: <Pine.SOL.4.44.0208131855520.25942-100000@rastan.gpcc.itd.umich.edu> <PPENJLMFIMGBGDDHEPBBKECLDKAA.ashokr2@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <PPENJLMFIMGBGDDHEPBBKECLDKAA.ashokr2@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Quoting Ashok Raj <ashokr2@attbi.com>:

> Is anyone aware of usb drivers for the XIRCOM usb->serial adapters...

You mean one of those?

USB Xircom / Entregra Single Port Serial Driver
CONFIG_USB_SERIAL_XIRCOM
  Say Y here if you want to use a Xircom or Entregra single port USB to
  serial converter device.  This driver makes use of firmware
  developed from scratch by Brian Warner.

  This code is also available as a module ( = code which can be
  inserted in and removed from the running kernel whenever you want).
  The module will be called keyspan_pda.o. If you want to compile it
  as a module, say M here and read <file:Documentation/modules.txt>.

Dmitri

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9WeuCXksyLpO6T4IRAi/IAKCJvqCmxeqBc1A2sQvqV86jKlx70gCfQLml
H8t9vYxi9CAVUyLYTstJ3Ag=
=6m0K
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
