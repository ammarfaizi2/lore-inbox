Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937916AbWLGBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937916AbWLGBea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937924AbWLGBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:34:30 -0500
Received: from pat.uio.no ([129.240.10.15]:59700 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937916AbWLGBe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:34:29 -0500
Subject: Re: [GIT] Please pull the NFS client update for 2.6.19
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
In-Reply-To: <Pine.LNX.4.64.0612061713270.3542@woody.osdl.org>
References: <1165424156.5744.10.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0612061713270.3542@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 20:34:21 -0500
Message-Id: <1165455261.5744.71.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.76, required 12,
	autolearn=disabled, AWL 1.24, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 17:16 -0800, Linus Torvalds wrote:
> 
> On Wed, 6 Dec 2006, Trond Myklebust wrote:
> > 
> >    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git
> > 
> > This will update the following files through the appended changesets.
> 
> Well, right now it conflicts with the workqueue cleanups. Can you fix up 
> the conflicts and push again? Quite frankly, I could try, but since I 
> don't even run NFS, I _really_ don't think you want me to do so.

OK. I'll fix it up and resend.

Trond

