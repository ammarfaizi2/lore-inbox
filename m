Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUDEUkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUDEUkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:40:37 -0400
Received: from mail.shareable.org ([81.29.64.88]:5528 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263196AbUDEUkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:40:36 -0400
Date: Mon, 5 Apr 2004 21:40:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: bero@arklinux.org, linux-kernel@vger.kernel.org
Subject: Re: Catching SIGSEGV with signal() in 2.6
Message-ID: <20040405204028.GA21649@mail.shareable.org>
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu> <20040405181707.GA21245@mail.shareable.org> <4071B093.9030601@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071B093.9030601@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> SA_SIGINFO implies sigaction().  The original poster was talking about 
> signal().
> 
> That said, it seems to work with 2.6.4 on ppc32.

Just tried it with 2.6.3, x86 and signal().  Works fine.

-- Jamie
