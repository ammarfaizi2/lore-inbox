Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTF0FVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 01:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTF0FVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 01:21:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55730 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263752AbTF0FVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 01:21:53 -0400
Date: Thu, 26 Jun 2003 22:30:02 -0700 (PDT)
Message-Id: <20030626.223002.21926109.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to ask everyone NOT to use bugme.osdl.org
for networking bug reporting any more.

It's absolutely the wrong model.  When a bug gets filed that way
it sort of goes into a black hole that _I_ am forced to process,
forward, etc. the bug around and I don't want to be forced to do
mindless work like that when it is totally unnecessary.

I want people to post the bug to linux-net and netdev and discuss
the problem there.  And that solves all of the problems.

Thanks a lot.
