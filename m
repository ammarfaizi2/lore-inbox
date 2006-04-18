Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWDRRdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWDRRdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDRRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:33:53 -0400
Received: from thunk.org ([69.25.196.29]:54688 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932181AbWDRRdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:33:52 -0400
Date: Tue, 18 Apr 2006 12:06:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Fixes in the -stable tree, but not in mainline
Message-ID: <20060418160610.GA10933@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060417212946.GA3118@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060417212946.GA3118@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 02:29:46PM -0700, Greg KH wrote:
> Here are 5 patches that are in the -stable tree, yet not currently fixed
> in your mainline tree.  One of them is a security fix, so it probably
> would be a good idea to get it into there :)

I thought one of the requirements for accepting a patch into -stable
was that it was already in mainline.  Was this a change in policy that
I missed, or just an oversight when we vetted these patches?

Not that I have anything against these patches, just curious in the
future if we should NACK patches proposed for -stable if we notice
that they aren't yet in mainline.

						- Ted
