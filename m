Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWAEKE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWAEKE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWAEKE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:04:26 -0500
Received: from triton.atia.com ([193.16.246.115]:42258 "EHLO triton.atia.com")
	by vger.kernel.org with ESMTP id S1750959AbWAEKEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:04:25 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
 (realtime-preempt)
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	<20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	<87u0cj5riq.fsf_-_@arnaudov.name>
	<1136436273.12468.113.camel@localhost.localdomain>
From: Nedko Arnaudov <nedko@arnaudov.name>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAM1BMVEX///8HBgUeFhGwUjwr
 NDF5RjOgVz2UVTxxTz9pNSXCiW2OUjhNIxi6bE6ROChWammgrK7+pa2IAAAAAXRSTlMAQObYZgAA
 AkxJREFUeAGtlAuTgyAMhK9gIGl4+P9/7W2wVbBo52YOZ2of+djdBPtT/7h+/lhf/wNYXFtLu38Y
 OCss7jEut4zMCTiXGzwiA7CMm78+XQPzemC9q15hun/7sovRAZcCg8QBfPRnF3QPd0jswHW9gUeK
 rwC2nwPTCRyudk9vhXtHXYgT4FxKOEn7zu83R+o3ULefUipKxjTn73LcPyzVbdck0YdAclJxE8C2
 hKHiM5ZKGm1NLFn9IyUNBoQzMZsDjCKxD89sl6dBYwJYCFgi/8TKGfWWYzPmDkfdM40nEgRSWIYE
 NREkQcdMem9SBzAStJJiCaxcpOAy4HDUARWbJyyRAKKwzbBoKQmAzBSqw/7iOJaYC+mTSYtiJs3d
 FFjggTkGKr54r6gPwRoMZboASonB+wJA2/wQ32tysfAU4MWr97kBuLdx4FNy5QKoCfVYprCdEAhE
 tFY7gb5LlcnqMwIgBASaI3S4S1AHoO7ASwH+bCTdFE4AmxP4wcIJMQFPaN01YBI5F7QT9wagq5KO
 FuHd/sS1b8VCUMTeofUV07gH4Cno1iuo2BQY079RqKSK49MWYcyBSOgWEMWk2iCsUV4RQW6BNopN
 wYJYBB7GcAqN2UXLbc3Cssyk9wpiw7NimwPqkemLArVZGBKIhWP8qkCExyaHHBn+Y4iR+rP3mQH1
 zKpMuDjmZ8DHfhDjpCsyYkUsxqsZy3EcxAgsDUCl/TnZYcJLgLVOogPWKkIB/rHzVm9QyGzE+mZ2
 YF1XHAQcPPy51kOhecI06vpCfgFqlF1IG9UTLgAAAABJRU5ErkJggg==
Date: Thu, 05 Jan 2006 12:03:52 +0200
In-Reply-To: <1136436273.12468.113.camel@localhost.localdomain> (Steven
 Rostedt's message of "Wed, 04 Jan 2006 23:44:33 -0500")
Message-ID: <87u0cj3saf.fsf@arnaudov.name>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> writes:

> Could you send me your .config.  And this is a smp machine right?

No it is not. Sending you my config personally.

=2D-=20
Nedko Arnaudov <GnuPG KeyID: DE1716B0>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvO8S6bb4v94XFrARAqRrAKCQIpLs0eNwAoBbr/k+mf932RDOugCdEuZW
+Ur8fKR4bHQKU2zltNe1DNs=
=rlf7
-----END PGP SIGNATURE-----
--=-=-=--

