Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTHHHJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271293AbTHHHJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:09:09 -0400
Received: from [66.212.224.118] ([66.212.224.118]:2067 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271289AbTHHHJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:09:02 -0400
Date: Fri, 8 Aug 2003 02:57:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jasper Spaans <jasper@vs19.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <20030808065230.GA5996@spaans.vs19.net>
Message-ID: <Pine.LNX.4.53.0308080256340.30770@montezuma.mastecende.com>
References: <20030807180032.GA16957@spaans.vs19.net>
 <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
 <20030808065230.GA5996@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Jasper Spaans wrote:

> On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:
> 
> > > It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> > > I've just comiled all affected files (that is, the config resulting from
> > > make allyesconfig minus already broken stuff) succesfully on i386.
> > 
> > Arrrgh! You can't be serious!
> 
> Yes, I am bloody serious; this patch might look purely cosmetic at first
> sight.. yet, there's a technical reason for at least one part of it. Grep
> and see the horror:
> 
> $ egrep -ni 'flavou?r' fs/nfs/inode.c
> [snip]
> 1357:	rpc_authflavor_t authflavour;
> [snip]

I know it wasn't purely cosmetic but i just wish we could use the proper 
spelling instead of US English. No i'm not trolling.

-- 
function.linuxpower.ca
