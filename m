Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265126AbUD3JeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUD3JeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUD3JeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:34:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265126AbUD3JeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:34:18 -0400
Subject: Re: Re[2]: ~500 megs cached yet 2.6.5 goes into swap hell
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <18781898240.20040430121833@port.imtp.ilyichevsk.odessa.ua>
References: <40904A84.2030307@yahoo.com.au>
	 <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	 <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
	 <4091F38C.3010400@yahoo.com.au>
	 <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
	 <18781898240.20040430121833@port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OCQz3ztSbzxjMuesy14h"
Organization: Red Hat UK
Message-Id: <1083317615.4633.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Apr 2004 11:33:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OCQz3ztSbzxjMuesy14h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Multimedia content (jpegs etc) is typically cached in
> filesystem, so Mozilla polluted pagecache with it when
> it saved JPEGs to the cache *and* then it keeps 'em in RAM
> too, which doubles RAM usage.=20

well if mozilla just mmap's the jpegs there is no double caching .....


--=-OCQz3ztSbzxjMuesy14h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAkh1txULwo51rQBIRAoNbAJ9A13KM0TVigP9zE49v6Zvag9vDTwCdFpBk
n6iDTLXGiR/8KG1c6wJB85w=
=FqZ8
-----END PGP SIGNATURE-----

--=-OCQz3ztSbzxjMuesy14h--

