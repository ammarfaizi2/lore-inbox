Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263782AbUD0Ffo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUD0Ffo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUD0Ffo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:35:44 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:28840 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S263782AbUD0Fff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:35:35 -0400
Message-ID: <408DF117.4060309@tequila.co.jp>
Date: Tue, 27 Apr 2004 14:35:19 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2 + Adaptec I2O
References: <408DE95F.5010201@tequila.co.jp> <20040426221814.490a0cfd.akpm@osdl.org> <Pine.LNX.4.58.0404262223260.17702@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0404262223260.17702@dlang.diginsite.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Lang wrote:
| here is a config that is working with the patch I was sent, but will not
| compile with the stock drivers or with 2.6.5
|
| I am going to be spending the next week or so 'certifying' kernel/hardware
| combinations if you need me to test something.

on this URL [http://www.smartcgi.com/?action=docs,kernel26-adaptec] you
can find a patch that I could successfully path again 2.6.5 (vanilla)
and compile successfully.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjfEXjBz/yQjBxz8RAsZPAKCzcgWU+85vJRqh4Lu1iMslajA5JACg3UUH
w6Nx7uoMrrMSk7l9ZPESVUQ=
=Fxc7
-----END PGP SIGNATURE-----
