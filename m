Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWCWJZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCWJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCWJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:25:09 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:53437 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751415AbWCWJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:25:07 -0500
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org> <200603230901.57052.jos@mijnkamer.nl> <44225AB4.4080503@yahoo.com.au> <cone.1143104983.983347.31285.501@kolivas.org>
Message-ID: <cone.1143105898.702055.31285.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
Date: Thu, 23 Mar 2006 20:24:58 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-31285-1143105898-0003";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-31285-1143105898-0003
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Con Kolivas writes:

> Nick Piggin writes:
> 
>> Secondly, with or without swap prefetch, I think we can do a better job of
>> handling these use-once patterns to begin with.
> 
> Absolutely! But there will always be workloads that cause appropriate 
> use-once swapping. Qemu, games, big print jobs, big open documents, big 
> graphic edits and so on.

I meant appropriate and/or use-once.

Cheers,
Con


--=_mimegpg-kolivas.org-31285-1143105898-0003
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEImlqZUg7+tp6mRURAvCuAJ4hd1XsKRtOwOZMvhpJ6+wlGJBeMgCfa8A2
gwEyjfS0/dRFusXje3362rk=
=TjO3
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-31285-1143105898-0003--
