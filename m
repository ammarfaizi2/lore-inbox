Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWLAVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWLAVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWLAVG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:06:29 -0500
Received: from mx27.mail.ru ([194.67.23.64]:31282 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1161382AbWLAVG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:06:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.19: ALi M5229 - CD-ROM not found with pata_ali
Date: Sat, 2 Dec 2006 00:06:25 +0300
User-Agent: KMail/1.9.5
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200606220004.30863.arvidjaar@mail.ru> <200612012335.29179.arvidjaar@mail.ru> <20061201124837.6d0d8adb.randy.dunlap@oracle.com>
In-Reply-To: <20061201124837.6d0d8adb.randy.dunlap@oracle.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612020006.25784.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 01 December 2006 23:48, Randy Dunlap wrote:
> > +static unsigned long atapi_max_xfer_mask = ~0;
> > +module_param(atapi_max_xfer_mask, ulong, 644);
>
>                                             ^^^
> BTW:                                        0644
>

Tnx :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcJlRR6LMutpd94wRAoa2AJwMIINzZMYEef5z1uiZoszImXA0nwCgkhdB
SmFMtClM1+xEcmI6WZ8PkvY=
=co6P
-----END PGP SIGNATURE-----
