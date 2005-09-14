Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVIMVtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVIMVtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVIMVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:49:10 -0400
Received: from sls-ce5p321.hostitnow.com ([72.9.236.50]:50331 "EHLO
	sls-ce5p321.hostitnow.com") by vger.kernel.org with ESMTP
	id S1751056AbVIMVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:49:09 -0400
From: Chris White <chriswhite@gentoo.org>
Reply-To: chriswhite@gentoo.org
Organization: Gentoo
To: linux-kernel@vger.kernel.org
Subject: Re: Quick update on latest Linux kernel performance
Date: Wed, 14 Sep 2005 15:17:28 +0900
User-Agent: KMail/1.8.2
References: <200509132132.j8DLWJg04553@unix-os.sc.intel.com>
In-Reply-To: <200509132132.j8DLWJg04553@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1146630.RvEIGnlmlX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509141517.38985.chriswhite@gentoo.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p321.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1146630.RvEIGnlmlX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 14 September 2005 06:32, Chen, Kenneth W wrote:
> New performance result are posted on http://kernel-perf.sourceforge.net
> with latest data collected on kernel 2.6.13-git9.

[snip]

> Take a look at the performance data.  Comments and suggestions are always
> welcome and please post them to LKML.

The benchmarks here have a slight flaw in that the main hardware components=
=20
tested are not given.  About the only thing I can see regarding these tests=
=20
is what processor they run on.  Displaying network performance tests withou=
t=20
showing the network card or io tests without showing the disk controller=20
seems rather odd.  I guess it comes down to requesting a full hardware=20
rundown.  If this is displayed someplace on the site or elsewhere please=20
provide the link.

Chris White

--nextPart1146630.RvEIGnlmlX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDJ8CCFdQwWVoAgN4RAoRlAKCXQpel/i6eAhVXhytcrHY0mh5KIwCcDIrE
Hi/VW5ofVclfweCvC2JjH4E=
=mhtf
-----END PGP SIGNATURE-----

--nextPart1146630.RvEIGnlmlX--
