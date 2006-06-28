Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWF1Fra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWF1Fra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWF1Fr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:47:29 -0400
Received: from hera.kernel.org ([140.211.167.34]:49352 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1422658AbWF1Fr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:47:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc and what's the next step?
Date: Tue, 27 Jun 2006 22:47:19 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e7t557$u9o$1@terminus.zytor.com>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <200606271940.46634.ak@suse.de> <44A16E9C.70000@zytor.com> <bda6d13a0606271322x6f2d76f4wfdbc885062d9a145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1151473639 31033 127.0.0.1 (28 Jun 2006 05:47:19 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 28 Jun 2006 05:47:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bda6d13a0606271322x6f2d76f4wfdbc885062d9a145@mail.gmail.com>
By author:    "Joshua Hudson" <joshudson@gmail.com>
In newsgroup: linux.dev.kernel
> 
> BTW, is there a kinit= kernel command line so I can spawn an
> interactive shell rather than /init?  init= doesn't do it.
> 

Yes, it's called rdinit=.

	-hpa
