Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbUKZTzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUKZTzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKZTyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:53 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262610AbUKZTfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:08 -0500
Date: Thu, 25 Nov 2004 19:21:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 18/51: Debug page_alloc support.
Message-ID: <20041125182140.GH1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101295326.5805.259.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101295326.5805.259.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch provides support for making suspend work when DEBUG_PAGEALLOC
> is enabled.

Is swsusp1 broken in this config?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

