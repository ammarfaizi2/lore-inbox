Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVF0VEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVF0VEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVF0VD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:03:29 -0400
Received: from relay1.wplus.net ([195.131.52.143]:52781 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S261759AbVF0VBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:01:47 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 00:52:31 +0400
User-Agent: KMail/1.7.1
Cc: David Masover <ninja@slaphack.com>, vitaly@thebsh.namesys.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB7B32.4010100@slaphack.com> <42BC6307.3080808@namesys.com>
In-Reply-To: <42BC6307.3080808@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506280052.32571.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 23:46, Hans Reiser wrote:
> David Masover wrote:
> 
> 
> >
> >
> > I was able to recover from bad blocks, though of course no Reiser that I
> > know of has had bad block relocation built in...  
> 
> there was a patch somewhere.  Vitaly, please comment.

http://www.namesys.com/bad-block-handling.html describes 
how reiserfs handles bad blocks.

-- 
Thanks,
Vitaly Fertman
