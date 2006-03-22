Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWCVXmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWCVXmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCVXmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:42:23 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:14791 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964817AbWCVXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:42:22 -0500
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Message-ID: <cone.1143070934.645196.29698.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Date: Thu, 23 Mar 2006 10:42:14 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-29698-1143070934-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-29698-1143070934-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Peter Zijlstra writes:

> 
> This patch-set introduces a page replacement policy framework and 4 new 
> experimental policies.
> 
> The page replacement algorithm determines which pages to swap out.
> The current algorithm has some problems that are increasingly noticable, even
> on desktop workloads. As said, this patch-set introduces 4 new algorithms.

Wow with a new cpu scheduler and new vm we could fork linux now and take 
over the world!...

Or not...

Good luck :)

Cheers,
Con


--=_mimegpg-kolivas.org-29698-1143070934-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEIeDWZUg7+tp6mRURAlSxAJ96qRD+FQMmb2wtTiQSP9+bj7HiPwCfVM/7
RZtiZPqdey/fUWl9Jtf+sVc=
=UADT
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-29698-1143070934-0001--
