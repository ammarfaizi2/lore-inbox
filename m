Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWFFNHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWFFNHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWFFNHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:07:46 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53947 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932154AbWFFNHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:07:45 -0400
Date: Tue, 6 Jun 2006 09:07:43 -0400
To: Martin Hierling <martin.hierling@fh-luh.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060606130743.GB29283@fieldses.org>
References: <20060531164707.GA19547@cc.fh-luh.de> <20060531204716.GL13682@fieldses.org> <20060601115313.GB4561@cc.fh-luh.de> <20060605175229.GL16064@fieldses.org> <20060606073943.GB10020@cc.fh-luh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606073943.GB10020@cc.fh-luh.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 09:39:43AM +0200, Martin Hierling wrote:
> Hi Bruce, Hi List,
> 
> 
> > > > > [4] Linux version 2.6.16.18-xen (root@defiant)
> > > > Is there a xen patch applied as well?
> > > sure. 3.0.2-2
> > Well, this isn't a problem I can reproduce myself, and reading through
> > the code I don't see how this could happen.  So, grasping at straws a
> > bit, the only thing I can think to suspect is the xen patch.  I can't
> > find any "3.0.2-2" patch anywhere, though; where can I find that code?
> 
> http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-3.0.2-2-src.tgz
> 
> but as i wrote some days ago i found a memory error, so it did not
> happen since then because i swapped the RAM.
> 
> thanks for your investigation.

Whoops, sorry, missed that.--b.
