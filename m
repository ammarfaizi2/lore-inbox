Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275002AbTHQCkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275006AbTHQCkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:40:14 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:19599 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S275002AbTHQCkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:40:10 -0400
Date: Sat, 16 Aug 2003 19:39:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mitch Sako <msako@cadence.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g-2.6.0-test2-mm2-A5
Message-ID: <12650000.1061087975@[10.10.2.4]>
In-Reply-To: <3F3EC09C.7C29CABC@cadence.com>
References: <3F3EC09C.7C29CABC@cadence.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1816999384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1816999384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I'm having trouble applying Ingo's 4g-patches to linux-2.6.0-test2.  Is
> there a how-to or readme on this?  Basic hunk failures when using 'patch
> -p1' against the kernel source directory.

That's because they're on top of test2-mm2. Best bet is just to grab test3-mm2,
where they're already integrated, and than slap the attatched fix on top
(from Manfred).

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/2.6.0-test3-mm2.bz2

M.



--==========1816999384==========
Content-Type: application/octet-stream; name=44_fix
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=44_fix; size=342

Ci0tLSAyLjYuMC10ZXN0My1tbTIvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TLmRpc3QJMjAwMy0w
OC0xNSAxMzozMzoxMS4wMDAwMDAwMDAgLTA3MDAKKysrIDIuNi4wLXRlc3QzLW1tMi9hcmNoL2kz
ODYva2VybmVsL2VudHJ5LlMubmV3CTIwMDMtMDgtMTUgMTM6MDg6MTQuMDAwMDAwMDAwIC0wNzAw
CkBAIC00NTgsNiArNDU4LDcgQEAgd29ya19ub3RpZnlzaWc6CQkJCSMgZGVhbCB3aXRoIHBlbmRp
bmcgcwogCS8qCiAJICogUmVsb2FkIGRiNyBpZiBuZWNlc3Nhcnk6CiAJICovCisJbW92bCBUSV9m
bGFncyglZWJwKSwgJWVjeAogCXRlc3RiICRfVElGX0RCNywgJWNsCiAJam56IHdvcmtfZGI3CiAK

--==========1816999384==========--

