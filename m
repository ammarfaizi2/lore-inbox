Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbUJ1VqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUJ1VqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUJ1Vm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:42:58 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:37156 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262868AbUJ1Vj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HRNZzd26kdd5R3OZufXjiQxsQfWt2eDsLFbmL88CtajcRtxswTriUAi60YO03WoFhKhl3HowWFcO5BcX4GtAYPLYw+Wmu0tDR6p2LYegOcKgUeovqAmqmh7Rd0sSO1/wqwdzRcOeEKh8MZFFG9CdKxxR/otO68eZUcShJt3Z9a8=
Message-ID: <311601c9041028143915e1b607@mail.gmail.com>
Date: Thu, 28 Oct 2004 15:39:53 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: BK kernel workflow
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0410281120150.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041025162022.GA27979@work.bitmover.com>
	 <Pine.LNX.4.61.0410252350240.17266@scrub.home>
	 <20041026010141.GA15919@work.bitmover.com>
	 <Pine.LNX.4.61.0410270338310.877@scrub.home>
	 <20041027035412.GA8493@work.bitmover.com>
	 <Pine.LNX.4.61.0410272214580.877@scrub.home>
	 <20041028005412.GA8065@work.bitmover.com>
	 <Pine.LNX.4.61.0410280314490.877@scrub.home>
	 <20041028030939.GA11308@work.bitmover.com>
	 <Pine.LNX.4.61.0410281120150.877@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 23:03:42 +0200 (CEST), Roman Zippel
<zippel@linux-m68k.org> wrote:
    [munch]
> CVS by itself can't of course represent this history
    [munch]


At least you understand the problem, whether you realize it or not.

However, Larry's job isn't to make CVS better.  Why is this still
being argued? (oh yea, everyone is tired of arguing politics in the US
at least...)

--eric
