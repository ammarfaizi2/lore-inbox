Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUAJU0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbUAJU0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:26:21 -0500
Received: from mail.intercable.net ([207.248.32.22]:14852 "EHLO
	macross.intercable.net") by vger.kernel.org with ESMTP
	id S265427AbUAJU0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:26:15 -0500
Message-ID: <40005E9C.3030309@intercable.net>
Date: Sat, 10 Jan 2004 14:20:44 -0600
From: "Pablo E. Limon Garcia Viesca" <plimon@intercable.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UPDATE [bootup kernel panic 2.6.x]
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello again
Ive tried some advices you gave me, use hda=remap at boottime, puting
this options CONFIG_PARTITIO_ADVANCED=y and CONFIG_LDM_PARTITION=y,
taking out initrd suport. But I havnt had any improovment.
But I am starting to thing it is about how my HD is managed.
I have a SEGATE 20Gb drive. My BIOS does not recognize that amount of
disk, so I use a program that is on MBR provided by Segate that makes
the 20Gb abiavle. In kernel 2.4 it works just fine, but maybe that is
the cause 2.6 can not boot... am I right? what else could I try?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAF6cOGkG8a1Mf+oRAr8IAKCeiBNabvxPooIjcGf5d8s8JMPgMgCbBtKf
xD6t1aB8VuAbm+Sal/J5Mmg=
=rVmA
-----END PGP SIGNATURE-----

