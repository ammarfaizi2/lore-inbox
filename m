Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136593AbRA1MKn>; Sun, 28 Jan 2001 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRA1MKd>; Sun, 28 Jan 2001 07:10:33 -0500
Received: from linux.kappa.ro ([194.102.255.131]:32777 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S135980AbRA1MKY>;
	Sun, 28 Jan 2001 07:10:24 -0500
Date: Sun, 28 Jan 2001 14:10:02 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: Jens Axboe <axboe@suse.de>
Cc: Mark Bratcher <mbratche@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
Message-ID: <20010128141002.A11544@linux.kappa.ro>
In-Reply-To: <3A70EF20.1B02B307@rochester.rr.com> <3A72E8C7.138BB69E@rochester.rr.com> <20010128034300.A32375@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128034300.A32375@suse.de>; from axboe@suse.de on Sun, Jan 28, 2001 at 03:43:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 03:43:00AM +0100, Jens Axboe wrote:
> 
> It should be safe. Thanks for the feedback.


The patch works fine here too, but I have not tested it very hard ... just
normal read/write small/big files into it.

It looks fine here.

Any thoughts to integrate it into 2.4.1? What's Linus opinion?

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
