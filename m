Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCNQFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCNQFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVCNQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:05:24 -0500
Received: from mail.dif.dk ([193.138.115.101]:53676 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261554AbVCNQFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:05:19 -0500
Date: Mon, 14 Mar 2005 17:06:43 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][-mm][1/2] cifs: whitespace cleanups for file.c
In-Reply-To: <1110815990.2295.15.camel@smfhome.smfdom>
Message-ID: <Pine.LNX.4.62.0503141704070.2534@dragon.hyggekrogen.localhost>
References: <OF5618ED86.7D1043E7-ON87256FC4.00196859-86256FC4.0019866B@us.ibm.com>
  <Pine.LNX.4.62.0503141207550.2534@dragon.hyggekrogen.localhost> 
 <1110812782.2294.2.camel@smfhome.smfdom>  <Pine.LNX.4.62.0503141626400.2534@dragon.hyggekrogen.localhost>
 <1110815990.2295.15.camel@smfhome.smfdom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Steve French wrote:

> On Mon, 2005-03-14 at 09:36, Jesper Juhl wrote:
> 
> > Would it be useful if I split the second patch into a few parts for you? I 
> 
> For the second patch (the one I did not apply) slightly smaller would
> make things easier.  For patches that have non-trivial changes - my
> preference is to split the patches into the 50-200 line range since they
> can be reviewed and put in incrementally.
> 
I'll sort that out and send you such patches later this evening.


> those servers easily accessible to test against.   I am especially interested 
> in test feedback with current kernel/cifs against those with other
> servers (not just the usual Samba3, Samba4, current Windows).
> 
All I can get hold of easily is Samba3/4 on Linux, and probably Win2K. 
I /might/ be able to get hold of other stuff through work, but don't count 
on it. I'll see what I can do.


-- 
Jesper 

