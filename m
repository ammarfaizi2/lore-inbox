Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965951AbWKIEzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965951AbWKIEzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965952AbWKIEzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:55:04 -0500
Received: from [213.184.169.252] ([213.184.169.252]:19584 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S965951AbWKIEzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:55:02 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Thu, 9 Nov 2006 07:57:48 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090757.48744.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> On Wed, Nov 08, 2006 at 11:40:27PM +0100, Jesper Juhl wrote:
> > Let me make one very clear statement first: -stabel is a GREAT think
> > and it is working VERY well.
> > That being said, many of the fixes I see going into -stable are
> > regression fixes. Maybe not the majority, but still, regression fixes
> > going into -stable tells me that the kernel should have seen more
> > testing/bugfixing before being declared a stable release.
>
> Nice theory, but of course I'm pretty sure that it wouldn't work

Agreed.

> (as has been said numerous time before by other people).
>
> You cannot do endless testing/bugfixing, it's a psychological issue.

Agreed.

> If you do that, then you end up with -preXX (or worse, -preXXX)
> version numbers, which would cause too many people to wait and wait
> and wait with upgrading until "that next stable" kernel version
> finally becomes available.
> IOW, your tester base erodes, awfully, and development progress stalls.

IMHO, the psycho-problem is that you cannot intertwine development and stable 
in the same cycle.  In that respect, the 2.6 development cycle is a real 
flop, as it does not allow for focus.  

And focus is needed to achieve stability.  

Think catch22...


Thanks!

--
Al

