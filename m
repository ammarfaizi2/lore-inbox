Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTLJRCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLJRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:02:40 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:41461 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S263764AbTLJRCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:02:09 -0500
Message-ID: <3FD7507E.30601@inostor.com>
Date: Wed, 10 Dec 2003 08:57:34 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bonding gigabit cards w 2.4.20 switch question
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm testing bonding e1000 cards under 2.4.20 and it seems to work fine,
however: I would like to know a decent brand of switch that can support
round-robin or XOR at gigabit speeds.
Documentation/networking/bonding.txt has only 10/100 information in it.
Is there any preferred linux supporting brand?

Also, should I submit a bug report on the fact that bonding using the
ns83820.o driver causes kernel panics, or is that a known issue?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-nr2 (Windows 2000)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/11B+2dxAfYNwANIRAsauAJ9iBMGtGcNWO4sjClQyCuaslJNGdACfRkYf
PlcVYJ+fmFcXFQe8FRoI9Rk=
=vp6a
-----END PGP SIGNATURE-----

