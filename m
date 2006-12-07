Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967544AbWLGCRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967544AbWLGCRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 21:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967553AbWLGCRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 21:17:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967544AbWLGCRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 21:17:30 -0500
Date: Wed, 6 Dec 2006 18:17:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Subject: Re: [GIT] Please pull the NFS client update for 2.6.19
In-Reply-To: <1165455602.5744.73.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0612061812010.3615@woody.osdl.org>
References: <1165424156.5744.10.camel@lade.trondhjem.org> 
 <Pine.LNX.4.64.0612061713270.3542@woody.osdl.org>  <1165455261.5744.71.camel@lade.trondhjem.org>
 <1165455602.5744.73.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Trond Myklebust wrote:
> 
> Hmm... Have the workqueue updates been pushed out yet? I can't seem to
> pull them from git.kernel.org.

The kernel.org mirroring has been really flaky lately.

If you have an account, you can use master.kernel.org to get things 
without mirroring delays.

And if not, I'd be happy to push to other places too, but the reason 
kernel.org tends to occasionally get slow at mirroring is probably because 
it does get a lot of traffic. So..

		Linus
