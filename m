Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbTCGTmR>; Fri, 7 Mar 2003 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbTCGTmR>; Fri, 7 Mar 2003 14:42:17 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:39429 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261754AbTCGTmQ>; Fri, 7 Mar 2003 14:42:16 -0500
Date: Fri, 7 Mar 2003 19:52:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307195251.A14559@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303071950.h27JoIW12641.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303071950.h27JoIW12641.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 07, 2003 at 08:50:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 08:50:18PM +0100, Andries.Brouwer@cwi.nl wrote:
> > the prototype changes you did which make absolutely no sense
> > to get into 2.5 now when the functions will disappear before 2.6.
> 
> Maybe you are right.
> But as I said, my goal is to give us a 32-bit dev_t.
> It is not necessary to eliminate register_blkdev now,
> or before 2.6, in order to reach that goal.
> I agree completely that it should go away, and I moved it
> in front of the function it is going to be merged with.

Okay, and that part is fine with me, but please just leave the
prototype as-iw now, okay?

