Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVJGGgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVJGGgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJGGgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:36:33 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60576 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750999AbVJGGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:36:33 -0400
Date: Fri, 7 Oct 2005 02:36:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: John Rigg <lk@sound-man.co.uk>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
In-Reply-To: <E1ENgFH-00017G-HI@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510070234490.3816@localhost.localdomain>
References: <E1ENgFH-00017G-HI@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Oct 2005, John Rigg wrote:

> Below are excerpts from .config and from boot messages via serial
> console.

Hmm, I wonder if you're getting a stack overflow?

Have you tried this with turning on CONFIG_DEBUG_STACKOVERFLOW?

-- Steve
