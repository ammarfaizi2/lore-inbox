Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSA2WUd>; Tue, 29 Jan 2002 17:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbSA2WUX>; Tue, 29 Jan 2002 17:20:23 -0500
Received: from ns.suse.de ([213.95.15.193]:19726 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284300AbSA2WUK>;
	Tue, 29 Jan 2002 17:20:10 -0500
Date: Tue, 29 Jan 2002 23:20:09 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129232009.B12339@wotan.suse.de>
In-Reply-To: <p73aduwddni.fsf@oldwotan.suse.de> <200201292208.g0TM8ql17622@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201292208.g0TM8ql17622@ns.caldera.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:08:52PM +0100, Christoph Hellwig wrote:
> In article <p73aduwddni.fsf@oldwotan.suse.de> you wrote:
> > "Most times". For example the EA patches have badly failed so far, just because
> > Linus ignored all patches to add sys call numbers for a repeatedly discussed 
> > and stable API and nobody else can add syscall numbers on i386. 
> 
> There still seems to be a lot of discussion vs EAs and ACLs.

At least the last l-k discussion ended in relative conclusion as far as 
I remember (only disagreement was from someone wanting to implement them
in sys_reiser4) 

> Setting the suboptimal XFS APIs in stone doesn't make the discussion
> easier.

The presented APIs were not the XFS APIs, but a significantly revised 
version, based on a mix of ext2-acl and XFS and some new changes. 

See http://acl.bestbits.at/man/extattr.2.html and 
http://acl.bestbits.at/man/extattr.5.html

If you think anything is badly "suboptimal" proposal you should have stated
your criticism. 


-Andi

