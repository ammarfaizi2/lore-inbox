Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTLRIQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLRIQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:16:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263587AbTLRIQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:16:27 -0500
Date: Thu, 18 Dec 2003 03:16:25 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Nick Piggin <piggin@cyberone.com.au>,
       Joe Pranevich <jpranevich@kniggit.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wonderful World of Linux 2.6 - Final
In-Reply-To: <3FE1532A.2010109@pobox.com>
Message-ID: <Pine.LNX.4.58.0312180314330.17551@devserv.devel.redhat.com>
References: <3FE13D07.6080204@cyberone.com.au> <3FE1532A.2010109@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Dec 2003, Jeff Garzik wrote:

> Are you sure?  I could have sworn Ingo made the scheduler magically
> HT-friendly...

nope, it's not in 2.6 yet. This area is still under development, with
various approaches being considered.

	Ingo
