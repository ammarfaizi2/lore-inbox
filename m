Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEQFwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 01:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTEQFwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 01:52:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:53376 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261252AbTEQFwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 01:52:45 -0400
Subject: Re: Route cache performance under stress
From: "David S. Miller" <davem@redhat.com>
To: Simon Kirby <sim@netnation.org>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030516222436.GA6620@netnation.com>
References: <8765pshpd4.fsf@deneb.enyo.de>
	 <20030516222436.GA6620@netnation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053138910.7308.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 19:35:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 15:24, Simon Kirby wrote:
> I have been seeing this problem for over a year, and have had the same
> problems you have with DoS attacks saturating the CPUs on our routers.

Have a look at current kernels and see if they solve your problem.
They undoubtedly should, and I consider this issue resolved.

-- 
David S. Miller <davem@redhat.com>
