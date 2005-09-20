Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbVITRWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbVITRWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbVITRWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:22:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48022 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932766AbVITRWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:22:02 -0400
Message-ID: <43304531.4080201@namesys.com>
Date: Tue, 20 Sep 2005 10:21:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua> <20050918102658.GB22210@infradead.org> <b14e81f0050918102254146224@mail.gmail.com> <1127079524.8932.21.camel@localhost.localdomain> <432E4786.7010001@namesys.com> <432F8D1E.7060300@yahoo.com.au> <432FABFA.9010406@namesys.com> <1127200590.9436.15.camel@npiggin-nld.site> <432FC150.9020807@namesys.com> <20050920114253.GL10845@suse.de>
In-Reply-To: <20050920114253.GL10845@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>
>Seeing as you are the one that is apparently bothered by the misnomer,
>it follows that you would be the one submitting a patch for this. Not
>that it would be accepted though, I don't see much point in renaming
>functions and breaking drivers just because of a slightly bad name. The
>io schedulers are all called foo-iosched.c, it's only the simple core
>api that uses the 'elevator' description.
>
>  
>
He asked for an example of messy code, I gave one.  Nate can give
details on other messiness in that code.

Reiser4 has flaws also....

Give all the code time, and it will improve.  The "elevator" code has
gotten a LOT better.
