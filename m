Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275264AbTHSAk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275274AbTHSAkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:40:25 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:40627 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S275264AbTHSAkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:40:17 -0400
Message-ID: <3F4171DB.7040604@tequila.co.jp>
Date: Tue, 19 Aug 2003 09:39:55 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Clemens Schwaighofer <gullevek@gullevek.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-cvs: still a small oops afer boot
References: <200308121010.11139.gullevek@gullevek.org> <20030813235104.GC7863@kroah.com>
In-Reply-To: <20030813235104.GC7863@kroah.com>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:

> Try the patch at:
> 	http://bugme.osdl.org/show_bug.cgi?id=923
>
> It should fix it.

Yep, fixed it :)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/QXHajBz/yQjBxz8RAu0UAJ4jtuzRdE2vXH32iparfYcSj8a4XACfQfd0
4qxLMLaTNeH7iO3RHPGEBSk=
=jYqm
-----END PGP SIGNATURE-----

