Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273321AbRINGt3>; Fri, 14 Sep 2001 02:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273322AbRINGtT>; Fri, 14 Sep 2001 02:49:19 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:49416 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S273321AbRINGtD>; Fri, 14 Sep 2001 02:49:03 -0400
Date: Fri, 14 Sep 2001 01:49:03 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Val Henson <val@nmt.edu>
cc: becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
In-Reply-To: <20010913195141.B799@boardwalk>
Message-ID: <Pine.LNX.3.96.1010914014755.8683B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Val Henson wrote:
> And finally, I'd like to remove ncr885e.c entirely since it's
> redundant and extremely buggy.  Any objections?

I may be missing some context... have you tested yellowfin on big endian
boxes?  If so, go ahead and remove it.  Cort said it was destined for
the scrapheap a while ago, and IIRC it disappeared from the 'ac' tree
for a while...

