Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRIJTDX>; Mon, 10 Sep 2001 15:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIJTDD>; Mon, 10 Sep 2001 15:03:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:18409 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271597AbRIJTC7>;
	Mon, 10 Sep 2001 15:02:59 -0400
Date: Mon, 10 Sep 2001 21:03:15 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910210315.A24019@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de> <20010910200344.C714@athlon.random> <20010910204928.A22889@caldera.de> <20010910210116.B715@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910210116.B715@athlon.random>; from andrea@suse.de on Mon, Sep 10, 2001 at 09:01:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 09:01:16PM +0200, Andrea Arcangeli wrote:
> > I think the sd part is much more interesting for most users..
> 
> more interesting for most users certainly ;), but it's not needed for
> reliable operations so I thought you were talking about the paride
> fixes (also you quoted the 00_paride-... filename).

I said max_sectors fixes because I meant both.  The paride fixes are
needed, the sd ones nice - I'd like to see both merged :)

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
