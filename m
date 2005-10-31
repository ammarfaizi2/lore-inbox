Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVJaAST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVJaAST (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVJaAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:18:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50860 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932421AbVJaASR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:18:17 -0500
Date: Mon, 31 Oct 2005 00:18:10 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051031001810.GQ7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org> <200510310145.43663.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310145.43663.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:45:43AM +0100, Andi Kleen wrote:
> The problem is that -mm* contains typically so many more or less
> broken changes that any extensive work on there is futile 
> because you never know whose bugs you're debugging
> (and if the patch that is broken will even make it anywhere) 
> 
> In short mainline is frozen too long and -mm* is too unstable.

Besides, -mm is changing so fscking fast that it doesn't build on a lot
of configs most of the time.  And trying to keep track of it and at least
deal with build breakage at real time is, IME, hopeless.
