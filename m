Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUGJMJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUGJMJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUGJMJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:09:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266223AbUGJMJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:09:39 -0400
Date: Sat, 10 Jul 2004 14:05:53 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: ismail =?iso-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710120553.GA24713@devserv.devel.redhat.com>
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com> <1089458801.2704.3.camel@laptop.fenrus.com> <2a4f155d040710050166e98a7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <2a4f155d040710050166e98a7f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Jul 10, 2004 at 03:01:42PM +0300, ismail d=F6nmez wrote:
> cartman@southpark:~$ dmesg | grep sched
> Using anticipatory io scheduler
>=20
> Problem is I rarely do this copy operations like once a week or 2
> weeks. Guess there is no scheduler that fits both desktop usage +
> these kinds of operations?

CFQ seems to be quite good for desktop too in my experience...

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA79uhxULwo51rQBIRAl9KAJ4kxoCgjhx4Yfibr1JyhOqLZ1jnmQCgnKkq
Mb1hRxDRdxuHOrJxF0rZ4yA=
=p4xb
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
