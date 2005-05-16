Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVEPNqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEPNqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEPNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:45:59 -0400
Received: from zork.zork.net ([64.81.246.102]:64994 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261646AbVEPNpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:45:13 -0400
From: Sean Neakums <sneakums@zork.net>
To: "linux" <kernel@wired-net.gr>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 Kernel Threads
References: <002f01c55a1a$7c2cfda0$0101010a@dioxide>
Mail-Followup-To: "linux" <kernel@wired-net.gr>, "lkml"
	<linux-kernel@vger.kernel.org>
Date: Mon, 16 May 2005 14:40:12 +0100
In-Reply-To: <002f01c55a1a$7c2cfda0$0101010a@dioxide> (kernel@wired-net.gr's
	message of "Mon, 16 May 2005 16:23:44 +0300")
Message-ID: <6uwtpz5lxf.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux" <kernel@wired-net.gr> writes:

> can u tell how i can start/stop a kernel thread in 2.6.x series kernel???

If you are talking about creating kernel threads from your own code,
you probably want to have a look at include/linux/kthread.h

-- 
Dag vijandelijk luchtschip de huismeester is dood
