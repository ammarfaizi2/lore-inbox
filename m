Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJAVrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJAVrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUJAVPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:15:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:53678 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266517AbUJAUwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:52:13 -0400
Date: Fri, 1 Oct 2004 13:51:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Loops in the Signed-off-by process
In-Reply-To: <20041001134017.3f1c6d62.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0410011350490.2403@ppc970.osdl.org>
References: <1096658717.3684.980.camel@localhost> <Pine.LNX.4.58.0410011233370.2403@ppc970.osdl.org>
 <20041001134017.3f1c6d62.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Oct 2004, Paul Jackson wrote:
>
> The protocol for adding an Acked-by line mystifies me a little.
> 
> If I submit a patch after having a good discussion of it with
> Joe Blow, is it appropriate for me to add an Acked-by line for
> Joe on my own, or should I get his consent (or know him well
> enough to know he consents) or should I only so add if Joe
> asks me to?

The "acked-by" thing doesn't mean anything, so you should just use your 
own judgement. 

> In other words, does the presence of such a line commit Joe
> to any position on the patch, beyond perhaps not being too
> annoyed if he gets queries on it.

Nope. The annoyance factor is the only factor to take into account.

		Linus
