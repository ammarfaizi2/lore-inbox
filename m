Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTH1V6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTH1V6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:58:48 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:20486 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264318AbTH1V6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:58:47 -0400
Subject: Re: State of the CFQ scheduler
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030828194743.GH16684@suse.de>
References: <1062078948.17363.4.camel@pilot.stavtrup-st.dk>
	 <20030828194743.GH16684@suse.de>
Content-Type: text/plain
Message-Id: <1062107920.665.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 23:58:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 21:47, Jens Axboe wrote:

> It shouldn't be too hard to adapt the latest version from before -mm
> dropped it and adapting to the current kernels. If you want to give that
> a go, I'd be happy to help you out.

Why don't you post a patch against 2.6.0-test4 or 2.6.0-test4-mm1 on
LKML? I would like to start using CFQ again :-)

