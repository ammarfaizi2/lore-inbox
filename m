Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUBTPwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUBTPwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:52:22 -0500
Received: from big.switch.gts.cz ([195.39.57.241]:46311 "EHLO
	big.switch.gts.cz") by vger.kernel.org with ESMTP id S261300AbUBTPwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:52:17 -0500
Date: Fri, 20 Feb 2004 16:52:10 +0100
From: Petr Cisar <pc@big.switch.gts.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 radeon framebuffer problems
Message-ID: <20040220155210.GA30957@big.switch.gts.cz>
Reply-To: Petr Cisar <pc@gts.cz>
References: <200402181601.56209.silla@netvalley.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402181601.56209.silla@netvalley.it>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only the last line, when pushing Page Down in vi, I got mess all around the screen. To switch the consoles back and forth makes it clean again.

Petr

> Hello,
> the new radeon fb driver fails to clear the last console line after scrolling 
> up the screen.
