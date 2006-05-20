Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWETQWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWETQWm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWETQWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:22:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751420AbWETQWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:22:41 -0400
Date: Sat, 20 May 2006 09:20:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] net driver updates
Message-Id: <20060520092033.7d404315.akpm@osdl.org>
In-Reply-To: <20060520042856.GA7218@havoc.gtf.org>
References: <20060520042856.GA7218@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> Andrew Morton:
>        revert "forcedeth: fix multi irq issues"

Manfred just found the fix for this, so we should no longer need to revert.
