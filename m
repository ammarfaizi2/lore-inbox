Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDNWjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDNWjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDNWjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:39:11 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:6278 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261612AbVDNWiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:38:46 -0400
Message-ID: <425EEFBE.7080106@tin.it>
Date: Thu, 14 Apr 2005 17:33:34 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: David Lang <david.lang@digitalinsight.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>	 <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>	 <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain>	 <425C03D6.2070107@tin.it>	 <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz>	 <425E9FE2.6090102@tin.it>	 <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz>	 <425EC778.4070009@tin.it> <1113508514.6293.82.camel@laptopd505.fenrus.org>
In-Reply-To: <1113508514.6293.82.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD76F9A7269296D33854D29FF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD76F9A7269296D33854D29FF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> this is a joke right? If you really think this you have no idea what ABI
> stability means and how extremely hard it is to even sort of remotely
> approach it.

I know it's really hard, the only way of possibly having ABI is plannig 
things really carefully about every single thing, so knowing every 
single piece... It's freakin' hard.

> Trust me. It's *extremely* hard to impossible. Several security fixes
> can only be fixed this way. And it's REALLY fragile even if for other
> fixes. And I am very glad that the linux kernel people in general decide
> to not go for abi stability, the hacks that would be needed would be so
> obscene and the gains very very minimal. (it's open source, you have the
> source after all!)

The gains are simply a rough reuse of older modules! Just joking...

I was simply wondering how guys like beos/haiku (it's a microkernel... i 
know... don't even think about starting a flame) could get ABI/API... I 
mean, if it's true that they have... I don't think it's because of c++ 
instead of plain c...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enigD76F9A7269296D33854D29FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXu++4LBKhYmYotsRAmiOAJ9BqPVrK1b1yAWTTdEA+GHxD03WYwCdHsp8
hBnA1CH0XwR9KmD8RJlDn6k=
=DZ/3
-----END PGP SIGNATURE-----

--------------enigD76F9A7269296D33854D29FF--
