Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUKCAfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUKCAfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUKCAdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:33:52 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:52644 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262116AbUKBWc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:32:28 -0500
Message-ID: <41880AFA.7050202@free.fr>
Date: Tue, 02 Nov 2004 23:32:26 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040804
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Mathieu Segaud <matt@minas-morgul.org>
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <4186BE21.8050000@free.fr>
In-Reply-To: <4186BE21.8050000@free.fr>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I applied the following patch [http://lkml.org/lkml/2004/11/2/129]
from Jens Axboe  onto kernel 2.6.10-rc1-mm2 (succeeded with offset 2
lines) and it solved the problem.

Thanks.

BTW, is there a mean to reply to a post in lkml witout being
subscribed ?
- --
laurent


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBiAr6UqUFrirTu6IRAh8OAKC3bMrwHy8BFxOoEhg03VbQp9R5hACgu5pn
ZWguH7/6uODFa8NuhwinreQ=
=qXXZ
-----END PGP SIGNATURE-----
