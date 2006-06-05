Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751245AbWFERwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWFERwc (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWFERwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:52:31 -0400
Received: from mail.fieldses.org ([66.93.2.214]:7585 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1751245AbWFERwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:52:31 -0400
Date: Mon, 5 Jun 2006 13:52:29 -0400
To: Martin Hierling <martin.hierling@fh-luh.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060605175229.GL16064@fieldses.org>
References: <20060531164707.GA19547@cc.fh-luh.de> <20060531204716.GL13682@fieldses.org> <20060601115313.GB4561@cc.fh-luh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601115313.GB4561@cc.fh-luh.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 01:53:13PM +0200, Martin Hierling wrote:
> Hi Bruce, Hi List,
> 
>  On Wed, May 31, 2006 at 04:47:16PM -0400, J. Bruce Fields wrote:
> > On Wed, May 31, 2006 at 06:47:07PM +0200, Martin Hierling wrote:
> > > [4] Linux version 2.6.16.18-xen (root@defiant)
> > 
> > Is there a xen patch applied as well?
> 
> sure. 3.0.2-2

Well, this isn't a problem I can reproduce myself, and reading through
the code I don't see how this could happen.  So, grasping at straws a
bit, the only thing I can think to suspect is the xen patch.  I can't
find any "3.0.2-2" patch anywhere, though; where can I find that code?

--b.
