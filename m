Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUCHO64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 09:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUCHO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 09:58:56 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:56707 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262498AbUCHO6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 09:58:54 -0500
Message-ID: <404C8A35.3020308@helsinki.fi>
Date: Mon, 08 Mar 2004 16:59:01 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40408852.8040608@helsinki.fi>	<20040228104105.5a699d32.rddunlap@osdl.org>	<40419A1C.5070103@helsinki.fi> <20040301101706.3a606d35.rddunlap@osdl.org>
In-Reply-To: <20040301101706.3a606d35.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:

| All of the kernel interface functions to PCMCIA Card Services have
| changed in 2.6 so quite a bit of code will have to be changed here.
| You can ask Nokia for a 2.6 update since it is now released, or
| you can ask for help from the linux-wlan (or wlan-ng) project people,
| or you can compare a 2.4 PCMCIA kernel driver to a 2.6 PCMCIA kernel
| driver to see what changes are required.
|

I compared the orinoco_cs drivers in 2.4 and 2.6 and I updated the nokia
driver source. However now I get "-1 unknown symbol in module" when I
try to insmod the module... where should I start troubleshooting?

| --
| ~Randy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFATIo1rPQTyNB9u9YRAgVTAJ4vJ/S7mWWcU30fvKpzcRM9nKmpxgCfZ4nZ
q4G1syI9QNWxqCDjTlULzwk=
=I5O4
-----END PGP SIGNATURE-----
