Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTJaUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 15:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTJaUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 15:55:59 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:60877 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263562AbTJaUz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 15:55:58 -0500
Date: Fri, 31 Oct 2003 18:57:40 -0400
From: Rhino <rhino9@terra.com.br>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v17a
Message-Id: <20031031185740.7c152d8b.rhino9@terra.com.br>
In-Reply-To: <3FA08853.5050402@cyberone.com.au>
References: <3F913704.5040707@cyberone.com.au>
	<3FA08853.5050402@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__31_Oct_2003_18_57_40_-0400_GLwdDkMzx76/1C+Q"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__31_Oct_2003_18_57_40_-0400_GLwdDkMzx76/1C+Q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2003 14:41:07 +1100
Nick Piggin <piggin@cyberone.com.au> wrote:

> http://www.kerneltrap.org/~npiggin/v17a/
> 
> More balancing fixes. I also incorporated some of Andrew Theurer's
> ideas. I'm generally getting good numbers now, but using fairly
> synthetic benchmarks.
> 
> Now would be a good time to test if anyone is interested. Thanks.

well i didn't have the time to make extensive tests yet, but the behaviour improved a lot since v16,
and *looks* quite  better compared to test9 on a 2 way xeon p4 with hyperthreading enabled,
seeing  4 cpu's.

when i get back home, I'll try to make a few benchmarks.

--Signature=_Fri__31_Oct_2003_18_57_40_-0400_GLwdDkMzx76/1C+Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/oujoP7/1py/aJRgRAlvGAKDQo6IRRTpPA5SxHCoE5ZN/sk9ZPgCcCalN
/A6QpOn95ZXqDSrKbalt968=
=TzQY
-----END PGP SIGNATURE-----

--Signature=_Fri__31_Oct_2003_18_57_40_-0400_GLwdDkMzx76/1C+Q--
