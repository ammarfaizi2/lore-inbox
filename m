Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUI1TUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUI1TUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUI1TUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:20:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267709AbUI1TUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:20:05 -0400
Message-ID: <4159B920.3040802@redhat.com>
Date: Tue, 28 Sep 2004 12:18:56 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Posix compliant behavior of CLOCK_PROCESS/THREAD_CPUTIME_ID
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not the right person to comment on this, I hope Roland will.  Roland
has been working on an implementation of this clock.  I think the
situation is quite a bit more complicated than your patch suggests.  So,
please wait until he has time to comment.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBWbkg2ijCOnn/RHQRArRbAJ9jEv/jwYuHuxQeT7fITmBAixaP2wCfcu0e
Ysb9uKlNxF58eycti8tA2us=
=AHNp
-----END PGP SIGNATURE-----
