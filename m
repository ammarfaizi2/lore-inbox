Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUF0Ve3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUF0Ve3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUF0Ve3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 17:34:29 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:55488 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264430AbUF0VeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 17:34:23 -0400
Message-ID: <40DF3D5B.20208@kolivas.org>
Date: Mon, 28 Jun 2004 07:34:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.7-ck3
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset.
These are patches designed to improve system responsiveness with
specific emphasis on the desktop, but has scheduler changes
suitable/configurable to any workload

http://kernel.kolivas.org


Summary of features:
- - staircase7.7 scheduler

- - batch scheduling

- - isochronous scheduling

- - autoregulated swappiness

- - autotuned vm page inactivation

- - supermount-ng

- - default cfq I/O scheduler

- - config hz

- - bootsplash v3.14


Changes:
- - Some unhappy bugs made it into staircase7.4 so I've updated this to
staircase7.7 with the bugfixes without any other changes.


Comments, questions, suggestions welcome.

Thanks to those who sent feedback making it possible to find these bugs
quickly.

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3z1bZUg7+tp6mRURAnE/AKCGNY83aKUm40EAnlXU2mJdfzaO4ACbBVXA
2JuyUneNAPND1sTk95fc5NA=
=7t+U
-----END PGP SIGNATURE-----
