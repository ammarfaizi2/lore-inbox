Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWGCOJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWGCOJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWGCOJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:09:37 -0400
Received: from thunk.org ([69.25.196.29]:25225 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751171AbWGCOJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:09:36 -0400
Date: Mon, 3 Jul 2006 10:09:10 -0400
From: Theodore Tso <tytso@mit.edu>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.17-mm6
Message-ID: <20060703140910.GA11126@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Cedric Le Goater <clg@fr.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>
References: <20060703030355.420c7155.akpm@osdl.org> <44A90A7D.10201@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A90A7D.10201@fr.ibm.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 02:15:57PM +0200, Cedric Le Goater wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> 
> This patch fixes a minor issue between the statistic infrastructure
> patchset and the inode diet patchset.

Acked-by: "Theodore Ts'o" <tytso@mit.edu>

Sorry, I missed this one. 

						- Ted
