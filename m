Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269566AbUIRPbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269566AbUIRPbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUIRPbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:31:34 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:18189 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269566AbUIRP3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:29:30 -0400
Message-ID: <9e4733910409180829570ec17a@mail.gmail.com>
Date: Sat, 18 Sep 2004 11:29:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Bob Gill <gillb4@telusplanet.net>
Subject: Re: [2.6.9-rc2-bk] Network-related panic on boot
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091720002071f0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1095459971.8786.14.camel@localhost.localdomain>
	 <20040917154942.39034b0c.davem@davemloft.net>
	 <1095474316.5058.9.camel@localhost.localdomain>
	 <9e47339104091720002071f0f8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are patches that fix this on this thread:
[TRIVIAL] Fix recent bug in fib_semantics.c 

-- 
Jon Smirl
jonsmirl@gmail.com
