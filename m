Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVFUISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVFUISE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFUIQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:16:44 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:4228 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262053AbVFUH1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:27:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-ck2
Date: Tue, 21 Jun 2005 17:27:01 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
References: <200506211501.43473.kernel@kolivas.org>
In-Reply-To: <200506211501.43473.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart28717576.2BKn0DJaap";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506211727.04049.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart28717576.2BKn0DJaap
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 21 Jun 2005 15:01, Con Kolivas wrote:
> These are patches designed to improve system responsiveness and
> interactivity. It is configurable to any workload but the default ck* pat=
ch
> is aimed at the desktop and ck*-server is available with more emphasis on
> serverspace.

Build broke for UP sorry. Here's a quick update to ck2.

http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck2/patch-2.6.12-ck2.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck2/patch-2.6.12-ck2-server=
=2Ebz2

Added:
+sched-fix_up_build.patch=20
=46ix uniprocessor build

Thanks Matthew Hawkins for the heads up and build fix.

Cheers,
Con

--nextPart28717576.2BKn0DJaap
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCt8FIZUg7+tp6mRURAnwxAJ9GiBJo5VtcuuGo+uoVUBQoxWeyKQCfQ6QC
hgfYN91cBPCBpnjNy5FcGJM=
=dtM2
-----END PGP SIGNATURE-----

--nextPart28717576.2BKn0DJaap--
