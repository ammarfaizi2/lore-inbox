Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVCPKar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVCPKar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCPKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:30:47 -0500
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:16334
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S262341AbVCPKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:30:34 -0500
In-Reply-To: <20050315233620.GC14380@redhat.com>
References: <20050315152448.A1697@unix-os.sc.intel.com> <20050315233620.GC14380@redhat.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--482212001"
Message-Id: <3a4f52e0e5292d8f3588e5347c2bb21d@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>
From: Daniel Egger <de@axiros.com>
Subject: Re: [PATCH] Reading deterministic cache parameters and exporting it in /sysfs
Date: Wed, 16 Mar 2005 11:29:34 +0100
To: Dave Jones <davej@redhat.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-6--482212001
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 16.03.2005, at 00:36, Dave Jones wrote:

> I really want to live to see the death of /proc/cpuinfo one day,

Please don't. cpuinfo contains a vast amount of useful
information for a quick inspection which cannot be determined
usefully from userspace (think embedded devices) for very
little code.

Servus,
       Daniel

--Apple-Mail-6--482212001
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCOAqOchlzsq9KoIYRAoHlAKCF6oUYYw5CqDWnRZHBJSwrDadv9QCeKj84
sOpiKe7qv1B2vPBprvIowQs=
=HbPa
-----END PGP SIGNATURE-----

--Apple-Mail-6--482212001--

