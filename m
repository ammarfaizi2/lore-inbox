Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVFXTsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVFXTsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbVFXTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:48:00 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:13239 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263388AbVFXTqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:46:32 -0400
Message-ID: <42BC6307.3080808@namesys.com>
Date: Fri, 24 Jun 2005 12:46:15 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>, vitaly@thebsh.namesys.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com>
In-Reply-To: <42BB7B32.4010100@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:


>
>
> I was able to recover from bad blocks, though of course no Reiser that I
> know of has had bad block relocation built in...  

there was a patch somewhere.  Vitaly, please comment.

