Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUFZBpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUFZBpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266920AbUFZBpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:45:11 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:61586 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S266919AbUFZBpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:45:05 -0400
Message-ID: <40DCD51C.2050706@g-house.de>
Date: Sat, 26 Jun 2004 03:45:00 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Thunderbird 0.6 (X11/20040605)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: yoshfuji@linux-ipv6.org
CC: l.barnaba@openssl.it, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 INET6 Oops when executing tracepath6
References: <1088078069.6320.5.camel@nowhere.openssl.softmedia.lan> <20040624.211615.386508853.yoshfuji@linux-ipv6.org>
In-Reply-To: <20040624.211615.386508853.yoshfuji@linux-ipv6.org>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

YOSHIFUJI Hideaki / 	дс schrieb:
> In article <1088078069.6320.5.camel@nowhere.openssl.softmedia.lan> (at
Thu, 24 Jun 2004 13:54:30 +0200), Marcello Barnaba
<l.barnaba@openssl.it> says:
>
>
>>tracepath6 exited with SIGSEGV.
>
>
> Already fixed in current bk tree. Thanks.

oh, cool. i hit the same one with vanilla 2.6.7 today.

thanks for the fixing...

Christian.
- --
BOFH excuse #444:

overflow error in /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3NTd+A7rjkF8z0wRAn1yAJwOZVIrtNsUWaYLDU+f8dSLwqIyFwCghVyU
YMgeonAjd4ik2/YjY7TO+2E=
=A92a
-----END PGP SIGNATURE-----
