Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTIAQeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTIAQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:34:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:28872 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263040AbTIAQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:34:44 -0400
Subject: Re: bitkeeper comments
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
In-Reply-To: <20030901155915.GC1327@work.bitmover.com>
References: <1062389729.314.31.camel@cube>
	 <20030901140706.GG18458@work.bitmover.com> <1062430014.314.59.camel@cube>
	 <20030901154646.GB1327@work.bitmover.com>
	 <20030901165658.A24661@infradead.org>
	 <20030901155915.GC1327@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062434020.14183.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 17:33:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 16:59, Larry McVoy wrote:
> Hey, I'm not in the middle of this because I don't understand who is right
> and it's not my place to make that call.  I said "if Linus or Marcelo says
> do it"  specifically for the case that there is some hanky panky going on.
> On the other hand, it's perfectly possible that the wrong comment got 
> stuck in there and if that's the case why shouldn't it get fixed?

Presumably in the abstract "if you care" case you can generate this
change globally by excluding that changeset and all after, then
reapplying it with a different comment then reapplying all that follow ?

