Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbVKPHUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVKPHUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVKPHUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:20:47 -0500
Received: from peabody.ximian.com ([130.57.169.10]:20184 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751467AbVKPHUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:20:47 -0500
Subject: Re: [RFC][PATCH 0/6] PCI PM updates
From: Adam Belay <abelay@novell.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116062741.GD31375@suse.de>
References: <1132111856.9809.49.camel@localhost.localdomain>
	 <20051116062741.GD31375@suse.de>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 02:29:35 -0500
Message-Id: <1132126175.3656.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 22:27 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:30:55PM -0500, Adam Belay wrote:
> > Hi all,
> > 
> > This is my first wave of cleanups and improvements to PCI PM support.  I
> > would appreciate some comments.
> 
> Ohther than those minor comments, looks good.  Forgot the Signed-off-by:
> line though, I guess you don't want them applied :)
> 
> thanks,
> 
> greg k-h

Yeah, I wanted to get some comments first.  I really appreciate you
looking over them.  If there are no further issues, I'll fix the things
you pointed out and send the final version of these changes tomorrow.

I also have some more intrusive PCI PM changes coming soon.

Thanks,
Adam


