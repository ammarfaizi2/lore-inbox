Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbRE2LTD>; Tue, 29 May 2001 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbRE2LSy>; Tue, 29 May 2001 07:18:54 -0400
Received: from chiara.elte.hu ([157.181.150.200]:18186 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261856AbRE2LSh>;
	Tue, 29 May 2001 07:18:37 -0400
Date: Tue, 29 May 2001 13:16:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] raid-2.4.5-A0, minor fix
Message-ID: <Pine.LNX.4.33.0105291315040.3146-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-241177951-991135010=:3146"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-241177951-991135010=:3146
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch (against 2.4.5-ac3) fixes a compiler warning (triggered
by gcc 2.96) in the RAID include files.

	Ingo

--8323328-241177951-991135010=:3146
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="raid-2.4.5-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105291316500.3146@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="raid-2.4.5-A0"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvcmFpZC9tZF9rLmgub3JpZwlUdWUg
TWF5IDI5IDEyOjUwOjMwIDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4
L3JhaWQvbWRfay5oCVR1ZSBNYXkgMjkgMTI6NTA6NDAgMjAwMQ0KQEAgLTM4
LDYgKzM4LDcgQEANCiAJCWNhc2UgUkFJRDU6CQlyZXR1cm4gNTsNCiAJfQ0K
IAlwYW5pYygicGVyc190b19sZXZlbCgpIik7DQorCXJldHVybiAwOw0KIH0N
CiANCiBleHRlcm4gaW5saW5lIGludCBsZXZlbF90b19wZXJzIChpbnQgbGV2
ZWwpDQo=
--8323328-241177951-991135010=:3146--
