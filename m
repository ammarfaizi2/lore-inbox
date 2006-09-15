Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIOGPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIOGPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWIOGPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:15:10 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:17614 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750783AbWIOGPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:15:09 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: rohitseth@google.com
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
Date: Fri, 15 Sep 2006 08:15:19 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
In-Reply-To: <1158284314.5408.146.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1567608.CGKe4py7GJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609150815.19917.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1567608.CGKe4py7GJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rohit Seth wrote:
> This patch contains the Documentation for using containers.

> +5- Remove a task from container
> +	echo <pid> rmtask

echo <pid> > rmtask?

Please also give a short description what containers are for. From what I r=
ead=20
here I can only guess it's about gettings some statistics about a group of=
=20
tasks.

Eike

--nextPart1567608.CGKe4py7GJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFCkT3XKSJPmm5/E4RAj3zAJ9mCfzSGaz7ozW0XHq9TXAt1qxPyQCgmQmZ
scVK3cgo2v6LGS9wJF+hAS0=
=AcZB
-----END PGP SIGNATURE-----

--nextPart1567608.CGKe4py7GJ--
