Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVFZTGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVFZTGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFZTGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:06:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32186 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261572AbVFZTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:05:42 -0400
Message-ID: <42BEFC77.6000608@namesys.com>
Date: Sun, 26 Jun 2005 12:05:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>, vitaly@thebsh.namesys.com
CC: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <fa.d8odcmh.1u56sbb@ifi.uio.no> <fa.cg8nk4u.jj8tqg@ifi.uio.no> <42BE5058.4070307@reub.net>
In-Reply-To: <42BE5058.4070307@reub.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:

> Hi Hans,
>
> On 25/06/2005 12:38 a.m., Hans Reiser wrote:
>
>> fsck is better in V4 than it is in V3. Users should move from V3 to V4,
>> as V3 is obsolete. I agree on that Ted.
>
>
> Perhaps before moving to V4, reiser4progs-1.04 (the most recent I
> think) could be made to compile with gcc4/fedora core 4 system, and
> some of the warnings cleaned up.  There are a fair lot of them - all
> the same warnings as below but in a heap of different files.
>
I will ask Vitaly to look into this.  None of us at Namesys use fedora.....

Vitaly?

Hans
