Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269815AbUIDGWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269815AbUIDGWM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUIDGWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:22:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61902 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269815AbUIDGWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:22:08 -0400
Message-ID: <41395EE9.4040407@namesys.com>
Date: Fri, 03 Sep 2004 23:21:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Paul Jakma <paul@clubi.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <200409032145.i83LjdXG002843@localhost.localdomain> <413954B7.7050502@slaphack.com>
In-Reply-To: <413954B7.7050502@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>   I used the betas for months, and "metas"
> never burned me.

metas is much less likely than what clearcase uses to be hit 
accidentally (After all these years I forget what exactly clearcase 
special cases, maybe it was "@@").  When people using clearcase suffer a 
namespace collision, life goes on, no big deal, they structure a 
filename slightly differently and so what?  I mean, just how much do we 
suffer from not being able to use '/' in filenames?  Every once in a 
while it is annoying, but not that much....
