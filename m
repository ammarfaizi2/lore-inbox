Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTH2HAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 03:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTH2HAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 03:00:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39876 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264452AbTH2HAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 03:00:32 -0400
Date: Fri, 29 Aug 2003 08:59:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: State of the CFQ scheduler
Message-ID: <20030829065932.GL16684@suse.de>
References: <1062078948.17363.4.camel@pilot.stavtrup-st.dk> <20030828194743.GH16684@suse.de> <1062107920.665.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062107920.665.0.camel@teapot.felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28 2003, Felipe Alfaro Solana wrote:
> On Thu, 2003-08-28 at 21:47, Jens Axboe wrote:
> 
> > It shouldn't be too hard to adapt the latest version from before -mm
> > dropped it and adapting to the current kernels. If you want to give that
> > a go, I'd be happy to help you out.
> 
> Why don't you post a patch against 2.6.0-test4 or 2.6.0-test4-mm1 on
> LKML? I would like to start using CFQ again :-)

Heh, did you not read the email? :)

I'll see if I get squeeze it in today, stay tuned.

-- 
Jens Axboe

