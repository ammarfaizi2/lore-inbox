Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVKVDQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVKVDQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVKVDQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:16:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964889AbVKVDQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:16:22 -0500
Date: Mon, 21 Nov 2005 19:15:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Masters <jonathan@jonmasters.org>
cc: Andrew Morton <akpm@osdl.org>, Cal Peake <cp@absolutedigital.net>,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
In-Reply-To: <20051119034456.GA10526@apogee.jonmasters.org>
Message-ID: <Pine.LNX.4.64.0511211914470.13959@g5.osdl.org>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
 <20051116005958.25adcd4a.akpm@osdl.org> <20051119034456.GA10526@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Nov 2005, Jon Masters wrote:
> 
> I stuck a test in for first use and had floppy_release free up policy
> too. But there are a bunch of problems in the floppy driver I've noticed
> in going through it tonight (and there's only so much of that I can take
> at 03:43 on a Saturday morning). I'll hopefully followup again.

Can you do one that is against your previous patch that already got 
merged through Andrew? And sign off on it?

		Linus
