Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSJ0T4u>; Sun, 27 Oct 2002 14:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJ0T4u>; Sun, 27 Oct 2002 14:56:50 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:44562 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262510AbSJ0T4t>; Sun, 27 Oct 2002 14:56:49 -0500
Date: Sun, 27 Oct 2002 20:03:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tim Tassonis <timtas@cubic.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap doesn't work
Message-ID: <20021027200308.A26047@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tim Tassonis <timtas@cubic.ch>, linux-kernel@vger.kernel.org
References: <E185tHb-0002mq-00@trivadis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E185tHb-0002mq-00@trivadis.com>; from timtas@cubic.ch on Sun, Oct 27, 2002 at 08:41:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 08:41:10PM +0100, Tim Tassonis wrote:
> Not that I would know better or have an idea why this bug happens, but to
> say "Bugger off if you have an lfs system" is a bit lousy, I think. After
> all, lfs has not really an "unstrusted toolchain", as compared to
> RH/Suse's/Debian "trustworthy computing toolchains":

Sorry, tons of people that have absolute no clue about the package
internals set up their systems themselves and make mistakes.  nothing
spectacular, but they just don't have those people who know the
packages in detail and can notice and fix the bugs.  Just get binary
rpm/deb whatever of the toolchain and reproduce.

> lfs has a manual with clearly specified package versions, patches and
> order of "toolchaining". It might well be a bug in that chain, but other
> distros have bugs, too. Signing software doesn't make it superior, after
> all.

but having people who understand the software maintain the
packages sometimes helps :)

