Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUJ3X5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUJ3X5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUJ3Xzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:55:40 -0400
Received: from linuxfools.org ([216.107.2.99]:32670 "EHLO loki.linuxfools.org")
	by vger.kernel.org with ESMTP id S261440AbUJ3Xx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:53:58 -0400
Date: Sat, 30 Oct 2004 19:17:00 -0400
From: jhigdon@linuxfools.org
To: Rik van Riel <riel@redhat.com>
Cc: Z Smith <plinius@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: in-kernel GUI project
Message-ID: <20041030231700.GA13402@linuxfools.org>
References: <4184124B.4090602@comcast.net> <Pine.LNX.4.44.0410301905460.8844-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410301905460.8844-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:06:47PM -0400, Rik van Riel wrote:
> On Sat, 30 Oct 2004, Z Smith wrote:
> 
> > I've been developing an in-kernel 2D GUI for kernel 2.6.
> > It's based on the framebuffer with the event subsystem
> 
> What about video cards where the framebuffer does not
> provide for acceleration, but the X drivers do ?
> 
> Do you plan to use the X server for better performance
> on such systems ?
> 

According to the website it's bloat so I imagine no.
Why didn't someone think of this before, put it in the kernel
solve software bloat! </sarcasm>

> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
