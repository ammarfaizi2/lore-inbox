Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTB1QPx>; Fri, 28 Feb 2003 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbTB1QPx>; Fri, 28 Feb 2003 11:15:53 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:13870 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S268004AbTB1QPw>;
	Fri, 28 Feb 2003 11:15:52 -0500
Message-ID: <3E5F8DA5.9050804@acm.org>
Date: Fri, 28 Feb 2003 10:26:13 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI request/release generic address
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there a way in the ACPI code to do a request/release of I/O or memory
with an acpi_generic_address?  Does it even make sense to do this?
There are generic I/O routines for using a generic address, and I'm
working with an ACPI table that has a generic address, so it would seem
to make sense to have memory reservation routines through this, too.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+X42jIXnXXONXERcRAglFAJ9Xn7HbRDCFkpDiAzrsB0lkYFdSGACfUxX4
enhfmod5mAZBAorygt1zrqo=
=wXF6
-----END PGP SIGNATURE-----

