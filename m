Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSDVV6k>; Mon, 22 Apr 2002 17:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314832AbSDVV5B>; Mon, 22 Apr 2002 17:57:01 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:10140 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S314834AbSDVV4Y>; Mon, 22 Apr 2002 17:56:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 22 Apr 2002 15:04:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <20020422164728.H20999@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0204221446070.1578-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Jeff Garzik wrote:

> The real question, as I understand it, is whether or not the kernel doc
> should be in the kernel source or not.  If the answer is 'no', then I
> fully support making it a URL, or printing it out the back of
> phonebooks, or whatever means of distribution :)

i really tried to remain out of this. in theory, like Linus said, we
should not even know that he's using bk. it should be completely hidden.
the only method described inside the kernel tarbal should be the
old diff+patch one. main maintainers ( i mean the group of at most 10 that
are handling huge number of patches and that are highly interacting with
Linus ) will very likely get benefits from using bk instead of diff+patch,
but for these one no doc is necessary. either they know or Larry can
provide them with all the docs they need. for all the remaining crew, bk
adoption is simply a trend followup.




- Davide



