Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbUK0ESo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbUK0ESo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbUK0D7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262382AbUKZTaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:35 -0500
Date: Thu, 25 Nov 2004 17:57:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 5/51: Workthread freezer support.
Message-ID: <20041125165755.GD476@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293394.5805.209.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101293394.5805.209.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This thread adds freezer support for workthreads.
> 
> A new parameter in the create_ functions allows the thread to be marked
> as PF_NOFREEZE. This should only be used for threads that may need to
> run during writing the image.

Ok.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

