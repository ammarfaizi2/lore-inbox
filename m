Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTJ0UL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTJ0UL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:11:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:19928 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263488AbTJ0UL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:11:56 -0500
Date: Mon, 27 Oct 2003 12:20:57 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: David Brownell <david-b@pacbell.net>
cc: ian.soboroff@nist.gov, <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend still broken in -test9
In-Reply-To: <3F9D62DD.9020503@pacbell.net>
Message-ID: <Pine.LNX.4.44.0310271219040.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Oct 2003, David Brownell wrote:

> Those are the same symptoms I saw in test7, fixed by:
> 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2
> 
> Patrick, were you going to submit your patch to resolve this?
> I'm thinking this kind of problem would meet Linus's test10
> integration criteria.

I should be merging early this week. Sorry about the delay, but it will 
get in soon.

BTW, can you help with any of the uhci-hcd suspend/resume issues? I do not 
know the code well enough to track it down.. 


	Pat



