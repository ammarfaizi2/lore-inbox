Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIOOT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIOOT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIOORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:17:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266173AbUIOONV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:13:21 -0400
Subject: Re: [patch] tune vmalloc size
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, kkeil@suse.de
In-Reply-To: <m34qlzbqy6.fsf@averell.firstfloor.org>
References: <2EHyq-5or-39@gated-at.bofh.it>
	 <m34qlzbqy6.fsf@averell.firstfloor.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aCDOU3lDBRhHudFCcTdL"
Organization: Red Hat UK
Message-Id: <1095257576.2698.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 16:12:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aCDOU3lDBRhHudFCcTdL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-15 at 15:29, Andi Kleen wrote:
> But I think this should be self tuning instead. For a machine with=20
> less than 900MB of memory the vmalloc area can be automagically increased=
,
> growing into otherwise unused address space.=20

that is the case already

this patch is for the other case

--=-aCDOU3lDBRhHudFCcTdL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSE3oxULwo51rQBIRArhWAJ0UV1S5TlDOOEDGMDaYIZnucYHXzgCfV9Xh
rmfNWdD2/PFM96GoS99r884=
=68IY
-----END PGP SIGNATURE-----

--=-aCDOU3lDBRhHudFCcTdL--

