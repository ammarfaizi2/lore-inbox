Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULTDpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULTDpu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbULTDpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:45:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261404AbULTDpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:45:45 -0500
Date: Sun, 19 Dec 2004 19:45:30 -0800
Message-Id: <200412200345.iBK3jUwP007592@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: Christoph Lameter's message of  Sunday, 19 December 2004 19:30:01 -0800 <Pine.LNX.4.58.0412191923360.1580@schroedinger.engr.sgi.com>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure what the point of these is? 

Andrew doesn't want to put the new code in until after 2.6.10 is released.
He asked me to back out the userspace-visible changes since 2.6.9, so
2.6.10 will have no additions rather than having something different from
what we settle on finally.  


Thanks,
Roland
