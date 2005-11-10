Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVKJXNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVKJXNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVKJXNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:13:08 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:53467 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932245AbVKJXNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:13:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Date: Fri, 11 Nov 2005 10:12:19 +1100
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       davej@codemonkey.org.uk, blaisorblade@yahoo.it
References: <20051110170040.GE16994@inskipp.digriz.org.uk>
In-Reply-To: <20051110170040.GE16994@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2446939.fCYSCLKqVx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511111012.22163.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2446939.fCYSCLKqVx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 11 Nov 2005 04:00, Alexander Clouter wrote:
> The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
> This removes the sysfs file 'ignore_nice' and in its place creates a
> 'ignore_nice_load' entry which defaults to '0'; meaning nice'd processes
> *are* counted towards the 'business' caclulation.

My 'nice'd compiles thank you from the bottom of their little cc1 hearts fo=
r=20
changing your mind.

Cheers,
Con

--nextPart2446939.fCYSCLKqVx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDc9PWZUg7+tp6mRURArmtAJ9LFT6bjL7974jGpAfhhnWPEcvCewCffSGy
ZigEdwwQcpx1kKS8SbY9NXQ=
=1woe
-----END PGP SIGNATURE-----

--nextPart2446939.fCYSCLKqVx--
