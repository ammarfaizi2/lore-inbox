Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUIMC2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUIMC2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUIMC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:28:36 -0400
Received: from pc221.tbwajapan.co.jp ([211.14.136.221]:28624 "HELO
	nabe.tequila.jp") by vger.kernel.org with SMTP id S264953AbUIMC2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:28:34 -0400
Message-ID: <414505C8.3020307@tequila.co.jp>
Date: Mon, 13 Sep 2004 11:28:24 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040813 Thunderbird/0.7.3 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ngo giang <ngohoanggiang1981dh@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can not reboot when build kernel
References: <20040913020235.21673.qmail@web51602.mail.yahoo.com>
In-Reply-To: <20040913020235.21673.qmail@web51602.mail.yahoo.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ngo giang wrote:
| Hello,

| cp arch/i386/boot/bzImage /boot/bzImage-2.4.26
~                                  ^^^^^^^^^^^^^^
| title kernel 2.4.26
| kernel /boot/vmlinuz-xxx
~               ^^^^^^^^^^^

you copied to the wrong name ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBRQXIjBz/yQjBxz8RAuVQAJ9kflJBHntaqg4ipfGK7GPSfXfRrQCfWSE5
RRIYvNzXbfUp2Zb5Nx1yPeE=
=m8mT
-----END PGP SIGNATURE-----
