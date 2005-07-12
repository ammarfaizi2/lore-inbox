Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVGLGqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVGLGqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGLGqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:46:45 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:36026 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261196AbVGLGqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:46:43 -0400
Subject: Re: [PATCH] [13/48] Suspend2 2.1.9.8 for 2.6.12:
	403-debug-pagealloc-support.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710230239.GA513@infradead.org>
References: <11206164393426@foobar.com> <1120616440281@foobar.com>
	 <20050710230239.GA513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121150906.13869.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:48:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 09:02, Christoph Hellwig wrote:
> this is missing a description.  But I don't think that one is gonna help, we're
> not gonna add truckloads of crap just to print a warning when a user shoots himself
> in his foot.

I would like to improve this so we actually check the mount time for the
filesystems, but this was a simpler intermediate step.

It may seem superfluous to you, but Suspend2 has over 12,000 users, and
not all of them are expert users. Not everyone gets it right first time.

Regards,

Nigel 
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

