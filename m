Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUIGSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUIGSOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUIGSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:13:50 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25551 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268321AbUIGSMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:12:12 -0400
Message-ID: <413DF9D2.5060703@namesys.com>
Date: Tue, 07 Sep 2004 11:11:30 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Spam <spam@tnonline.net>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>	<413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>	<1183150024.20040907143346@tnonline.net> <m38ybmjiyz.fsf@zoo.weinigel.se>
In-Reply-To: <m38ybmjiyz.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:

>Spam <spam@tnonline.net> writes:
>
>  
>
>>>Additionally, files-as-directores does not solve the problem of 
>>>"cp a b" losing named streams.
>>>
reiser4 does not support streams, it supports files that can do what 
streams do. cp -r does not currently lose files.

