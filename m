Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUA3Lwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUA3Lwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:52:43 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:34791 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263260AbUA3Lwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:52:40 -0500
Date: Fri, 30 Jan 2004 11:50:56 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rui Saraiva <rmps@joel.ist.utl.pt>, linux-kernel@vger.kernel.org
Subject: Re: Where is sparse?
Message-ID: <20040130115056.GA7164@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Rui Saraiva <rmps@joel.ist.utl.pt>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401300531490.32759@joel.ist.utl.pt> <Pine.LNX.4.58.0401292216110.689@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401292216110.689@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 10:18:47PM -0800, Linus Torvalds wrote:

 > > Where is the sparse source? (AKA TSCT - The Silly C Tokenizer) There was
 > > the BK repository at bk://kernel.bkbits.net/torvalds/sparse, now
 > > unavailable and the ml owner-linux-sparse@vger.kernel.org seems dead.
 > 
 > The old repostitory got killed when bkbits.net went away. There's a new
 > repo at
 > 
 > 	http://sparse.bkbits.net/sparse

I mailed you about this a while ago, when it disappeared, but never got
an answer.. anyway, I've repointed the daily snapshots to pull from here.
as always, they're at http://www.codemonkey.org.uk/projects/bitkeeper/sparse/

 > > There is other BK rep at bk://linux-dj.bkbits.net/sparse but it is an old
 > > version.
 > 
 > It may well be up-to-date: without anybody interested enough to do a 
 > back-end

Maybe slightly behind, I forget.. it was a throw-away tree I used for 1-2
small changes for Jeff to pull iirc.

	Dave

