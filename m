Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVB1X7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVB1X7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVB1X7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:59:23 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29904 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261828AbVB1X7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:59:19 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050225233823.GC29496@kroah.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <20050225233823.GC29496@kroah.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 18:58:01 -0500
Message-Id: <1109635081.28403.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 15:38 -0800, Greg KH wrote:
> On Thu, Feb 24, 2005 at 01:22:01AM -0500, Adam Belay wrote:

> > I look forward to any comments or suggestions.
> 
> I like it all :)
> 
> If you want to submit patches now that rearrange the code to make it
> easier for you to modify in the future to achieve the above goals, feel
> free, I'll gladly take them.
> 
> thanks,
> 
> greg k-h

I'm going to do an updated release soon.  It should take care of some of
the issues on the TODO list and also will be based on previous feedback.
>From there, I'll start planning a strategy for merging with mainline.  I
appreciate the comments.

Thanks,
Adam


