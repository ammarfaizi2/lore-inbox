Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVFKAS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVFKAS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFKAS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:18:59 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:51899 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261485AbVFKASw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:18:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Date: Sat, 11 Jun 2005 10:18:26 +1000
User-Agent: KMail/1.8.1
Cc: "J.A. Magallon" <jamagallon@able.es>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <1118445260l.7785l.0l@werewolf.able.es> <200506110959.53614.kernel@kolivas.org>
In-Reply-To: <200506110959.53614.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3202078.JXF3b6ID5i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506111018.29103.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3202078.JXF3b6ID5i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 11 Jun 2005 09:59, Con Kolivas wrote:
> Here is what the patch _should_ have been. (*same warnings with this patch
> about math demonstration and untested as should have been posted with the
> earlier one*)

Ok I booted this patch and all seems fine. Thanks to those that tracked dow=
n=20
this regression and the bugs, and apologies for the inconvenience. Looks li=
ke=20
Martin's automated testbed is already paying off.

Cheers,
Con

--nextPart3202078.JXF3b6ID5i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqi3VZUg7+tp6mRURAowFAJ4gzH/C+ezLm1yLQoZc77ARWqiklwCfXPHa
3mhygVbWiGuyosiTzUjNNbk=
=yur9
-----END PGP SIGNATURE-----

--nextPart3202078.JXF3b6ID5i--
