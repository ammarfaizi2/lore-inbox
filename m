Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVF1Akv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVF1Akv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVF1Akv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:40:51 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:21964 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261262AbVF1Akr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:40:47 -0400
Message-ID: <42C09C91.6000901@namesys.com>
Date: Mon, 27 Jun 2005 17:40:49 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prakash Punnoor <lists@punnoor.de>
CC: Steve Lord <lord@xfs.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org> <20050627202841.GA27805@thunk.org> <42C06873.7020102@xfs.org> <42C0868E.4080003@punnoor.de>
In-Reply-To: <42C0868E.4080003@punnoor.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:

>
>. But nevertheless it didn't survive, as like V3, with time V4 became
>slower and slower. In this case no year was needed, but just one month or
>alike. So end of test...but in fact I'll give V4 another go in the near future.
>  
>
Interesting that it got slower with time.  It sounds like our online
repacker is much needed.  It will be a priority for after the kernel merge.
