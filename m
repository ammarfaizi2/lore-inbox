Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWABX4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWABX4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWABX4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:56:37 -0500
Received: from triton.atia.com ([193.16.246.115]:12859 "EHLO triton.atia.com")
	by vger.kernel.org with ESMTP id S1751131AbWABX4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:56:36 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch-2.6.15-rc7-rt3 (realtime-preempt) report
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	<20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
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
Date: Tue, 03 Jan 2006 01:56:21 +0200
In-Reply-To: <87lkxyrzby.fsf_-_@arnaudov.name> (Nedko Arnaudov's message of
 "Tue, 03 Jan 2006 01:21:05 +0200")
Message-ID: <87lkxyyyje.fsf@arnaudov.name>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Just found another issue. Sometimes (say 1 of 10 tries), I get freeze
(nothing is logged at all), when I press ctrl-c just after starting
tse3play. I cannot freeze it with pmidi-1.6, so I'm not sure it is rtc
related at all. My tse3play is from tse3-0.3.1

http://tse3.sourceforge.net/

I'm playing midi file to qsynth.

LKML receivers, please CC me when replying. I'm currently not subscribed to=
 LKML.
=2D-=20
Nedko Arnaudov <GnuPG KeyID: DE1716B0>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDub2v6bb4v94XFrARAo4ZAJ9GraokBmC03CAvhINjFd/Q1pKEbwCfW3vO
mptQKMxaZkgbQwWW5KTyvSE=
=t7hz
-----END PGP SIGNATURE-----
--=-=-=--

