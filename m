Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272235AbTHIBUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTHIBUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:20:05 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:5126 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S272235AbTHIBR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:17:59 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Date: Sat, 9 Aug 2003 02:17:54 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090217.56224.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 Aug 2003 01:41, Linus Torvalds wrote:
> On 9 Aug 2003, Trond Myklebust wrote:
> > Since we appear to be in the silly season...
>
> No, your patch isn't silly, it's EVIL. It fundamentally breaks the notion
> of "grep for usage" by introducing two names to the same thing, without
> having even a good reason (ie no "nice abstraction" thing or anything).
>
> So that's just bad.
>
> In contrast, switching "authflavour" to "authflavor" (to match the type)
> ahs the advantage of _improving_ greppability.

... as long as you remember to misspell the word.

-- 
Ian.

