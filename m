Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUCSTML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUCSTML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:12:11 -0500
Received: from waste.org ([209.173.204.2]:57492 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263157AbUCSTMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:12:08 -0500
Date: Fri, 19 Mar 2004 13:11:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove kernel features (for embedded systems)
Message-ID: <20040319191149.GO11010@waste.org>
References: <20040318130640.GA28923@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318130640.GA28923@codeblau.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 02:06:40PM +0100, Felix von Leitner wrote:
> I propose to add the following kernel features to the removables:
> 
>   * /dev/kmem and /proc/kcore
>   * core dumping
>   * ptrace

These are all in 2.6-tiny already: http://selenic.com/tiny-about/

It's on my list of things to push to mainline.

> And if it is at all possible, I would like to be able to remove parts of
> the IP stack, e.g. routing.  In particular, I would like to be able to
> remove policy routing, if it is at all worth it from the code size point
> of view.

I've done small parts of this too.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
