Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVF1IpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVF1IpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVF1IoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:44:04 -0400
Received: from relay1.wplus.net ([195.131.52.143]:27955 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S261995AbVF1Ilm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:41:42 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 12:32:23 +0400
User-Agent: KMail/1.7.1
Cc: David Masover <ninja@slaphack.com>, Hans Reiser <reiser@namesys.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <200506280052.32571.vitaly@namesys.com> <42C06A84.9040201@slaphack.com>
In-Reply-To: <42C06A84.9040201@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281232.24245.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2005 01:07, David Masover wrote:
> Vitaly Fertman wrote:
> > On Friday 24 June 2005 23:46, Hans Reiser wrote:
> >
> >>David Masover wrote:
> >>
> >>
> >>
> >>>
> >>>I was able to recover from bad blocks, though of course no Reiser that I
> >>>know of has had bad block relocation built in...
> >>
> >>there was a patch somewhere.  Vitaly, please comment.
> >
> >
> > http://www.namesys.com/bad-block-handling.html describes
> > how reiserfs handles bad blocks.
> 
> Anything like this for v4?
 
in todo for v4, not implemented yet.

-- 
Thanks,
Vitaly Fertman
