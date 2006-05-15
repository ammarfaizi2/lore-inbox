Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWEOXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWEOXMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWEOXMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:12:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:49830 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750741AbWEOXMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:12:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 16:06:18 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e4b1ha$e1b$1@terminus.zytor.com>
References: <20060515005637.00b54560.akpm@osdl.org> <200605152037.54242.ak@suse.de> <1147719901.6623.78.camel@localhost.localdomain> <200605152111.20693.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1147734378 14380 127.0.0.1 (15 May 2006 23:06:18 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 15 May 2006 23:06:18 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200605152111.20693.ak@suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
> 
> > x86 is a legacy architecture now anyway, right? ;)
> I wish everybody would agree on that @)
> 

It's going to live on for a very long time, though.  Intel is still
shipping some very fast 64-bit-deficient silicon.  Once that's gone,
it's going to live on for decades in the embedded world.

	-hpa
