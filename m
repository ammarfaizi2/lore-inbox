Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVF0VL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVF0VL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVF0VJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:09:34 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:36615 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261815AbVF0VHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:07:20 -0400
Message-ID: <42C06A84.9040201@slaphack.com>
Date: Mon, 27 Jun 2005 16:07:16 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitaly Fertman <vitaly@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, vitaly@thebsh.namesys.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB7B32.4010100@slaphack.com> <42BC6307.3080808@namesys.com> <200506280052.32571.vitaly@namesys.com>
In-Reply-To: <200506280052.32571.vitaly@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vitaly Fertman wrote:
> On Friday 24 June 2005 23:46, Hans Reiser wrote:
> 
>>David Masover wrote:
>>
>>
>>
>>>
>>>I was able to recover from bad blocks, though of course no Reiser that I
>>>know of has had bad block relocation built in...  
>>
>>there was a patch somewhere.  Vitaly, please comment.
> 
> 
> http://www.namesys.com/bad-block-handling.html describes 
> how reiserfs handles bad blocks.

Anything like this for v4?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsBqhHgHNmZLgCUhAQLnqQ/8CNGlg/b2rS5TJi6Qzbi5E3eQMDXpU6GO
bQZCrZ60dhPGI0z5AqM+kpd4tfMqvF9pW83Pa4xPN9Snvs4RxJt79JutRss5JByF
ZrBdwt2Whq0Hmv5MxbIlCKof92thg3AL7HVmuKVgApAy85cOLH3C0CTMS00KjHqn
oVDO6gAYlZxJXd/Z+VqCILRTorcTJQXi7NaZy0ptSYPZlna/1JL+0JUOKOAQ8U++
8xK/ETwMwnWRd0/yZfrjE7Y1hU1bFlM5QAHKoRHnXfXEqXNm5eg+idsfCbrv80uw
+QuQy46Xl0puumcB1G6kp+WLboQe+u4fCn85osiWo8OzVcU4Q4hkqCjV6kOo6WH5
VYn/W3kEgdEpgxnkuDEG4uxiootzpUPUVLpVsK2GSqo5pdiNz63IGvt40WYQOnkc
I6/YPDTlHdmrFbxpASY05gMdtHYDEkvI7cw8MBeaK35Fr7S5VvCeRkEFI48CZHTw
Yz+wljq6v22tPmkdKZByXqIY+8A5hgSf2eBXGG4HBL9ogBFbj+IkueqhRQ9Z023J
EL7qYVlO0EDmpxb+8MbDYvugMXk6PlzebZLNu4Zw7S0sbkZFUhdkCQS3bnn22kJ4
UxYfsxy7fTUl5Rbdk+TzPbUX39U/fO9seZi6euEt6Dc3ak4g9lVnnzIo8GkwPBNF
7KRZCgN3wCw=
=7bqs
-----END PGP SIGNATURE-----
