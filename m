Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVF1TO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVF1TO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVF1TO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:14:56 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:53258 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261158AbVF1TO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:14:26 -0400
Message-ID: <42C1A18D.7000902@slaphack.com>
Date: Tue, 28 Jun 2005 14:14:21 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitaly Fertman <vitaly@namesys.com>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <200506280052.32571.vitaly@namesys.com> <42C06A84.9040201@slaphack.com> <200506281232.24245.vitaly@namesys.com>
In-Reply-To: <200506281232.24245.vitaly@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vitaly Fertman wrote:
> On Tuesday 28 June 2005 01:07, David Masover wrote:
> 
>>Vitaly Fertman wrote:
>>
>>>On Friday 24 June 2005 23:46, Hans Reiser wrote:
>>>
>>>
>>>>David Masover wrote:
>>>>
>>>>
>>>>
>>>>
>>>>>I was able to recover from bad blocks, though of course no Reiser that I
>>>>>know of has had bad block relocation built in...
>>>>
>>>>there was a patch somewhere.  Vitaly, please comment.
>>>
>>>
>>>http://www.namesys.com/bad-block-handling.html describes
>>>how reiserfs handles bad blocks.
>>
>>Anything like this for v4?
> 
>  
> in todo for v4, not implemented yet.

Is it significantly different that there'd be another doc I can read?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsGhjXgHNmZLgCUhAQJaeg/7BeQVRKc0m0AEKiwp6B/N/R6/32JcIvk9
0jZq3A6wYsSxmRSDfId+FVoHApAoZldOtw5CZ7W3TwUJBxzGwFZ7IYM4mQaZ5eRa
7CdAoX9LrG85sY/2M9qypE5cW6BQ/0DJFPDOiree/+6mNomg8uOUJ6FeO93j2JW3
jdPrWqsmYBPSDo4vKha+xoAZpCH/sMLwDDBUIFfC2iz4B4yTxYNfEX+mJ4T2mEls
3YqSiTMkgnFbsVTdUiIjqVJY+jJ9ALhDKdc/hkNNrNir3Iib6aNbg9J9J5cDgNHU
zzvNyp6WsCgQjtCvfMojVewKAMu94eg1sXt6ESNz4dKbdPBSdo+lBnATntnMjFCN
7nS9K/kKcTKwSVQjQdyEhbm51C9SXYLxj4CMcru9ZyVtdlyzCLhBda1FvaxWbatJ
iGCh8tg43Xkd1N4H+LlTQpJrfbkJBXu4U9oYIuNSQuolMfz6IbJqcfNzV0hm9drp
lGLODFSFEWFqHUgPqLymk8/pBW9xP4XYwwWFcY8x0Dw4UxpWRB43EZ8Nydg4PBEk
SrLnq1FNSP+QLHZvWwF+8vpWj1jyeiBU2hFpt/p9crU5uy4OWGbKEh8GuEHFgp9P
BdKzp4iwTFwgjKR/uM3JnCfN4ct0yyyBZVMNf0N8w2Idu4OkBiS2edg/70A8/OqV
U0JVANH5qxc=
=sd/Q
-----END PGP SIGNATURE-----
