Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCCQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCCQoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCCQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:44:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:32146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbVCCQoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:44:09 -0500
Date: Thu, 3 Mar 2005 08:43:53 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303164353.GE10761@kroah.com>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 08:23:39AM -0800, Linus Torvalds wrote:
> 
> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.
> 
> Anybody?

Well, I'm one person who has said that this would be a very tough
problem to solve.  And hey, I like tough problems, so I'll volunteer to
start this.  If I burn out, I'll take the responsibility of finding
someone else to take it over.

I really like the rules you've outlined, that makes it almost possible
to achieve sanity.

thanks,

greg k-h
