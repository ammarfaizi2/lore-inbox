Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbULPBlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbULPBlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbULPBk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:40:56 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:60837 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262620AbULPBhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:37:47 -0500
Message-ID: <41C0E720.8050201@comcast.net>
Date: Wed, 15 Dec 2004 20:38:40 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sockets from kernel space?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is it possible to create socket connections (AF_UNIX for example) from
the kernel to local user processes that are listen()ing?

A good link to somewhere to help with this would be nice.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwOcfhDd4aOud5P8RAkuYAJ0fvVUPHI5Wg3jn2ZNp0Y/2wSIRMgCfZDDb
jJ+HOC9hbvTj8a/niubR2Dc=
=ONFE
-----END PGP SIGNATURE-----
