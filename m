Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUFMAKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUFMAKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUFMAKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:10:48 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:17085 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264218AbUFMAKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:10:46 -0400
Message-ID: <40CB9B84.4030502@g-house.de>
Date: Sun, 13 Jun 2004 02:10:44 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Frequent system freezes after kernel bug
References: <20040612183742.GE1733@rocket> <20040612202023.GA22145@taniwha.stupidest.org> <20040612214947.GI1733@rocket>
In-Reply-To: <20040612214947.GI1733@rocket>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Schmidt wrote:
|> On Sat, Jun 12, 2004 at 08:37:42PM +0200, Andreas Schmidt wrote:
|>
|> > > kernel: EIP:    0010:[iput+44/592]    Tainted: P
|>
| fcdsl                 862816   2

could be totally unrelated, but please try to reproduce without this
(tainted) fcdsl module. it is often known for weird lockups. i'm not
able to tell from the oops message, so i have to ask: is this an SMP box?

Christian.
- --
BOFH excuse #314:

You need to upgrade your VESA local bus to a MasterCard local bus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAy5uD+A7rjkF8z0wRAnxzAKCoctKAT8NohJlkl6pFpbLmg/mS5ACgw416
B80DpO60XmMoKgzwyBEowBk=
=7Fns
-----END PGP SIGNATURE-----
