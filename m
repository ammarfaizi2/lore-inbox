Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTLRFsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLRFsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:48:25 -0500
Received: from smtp2.oregonstate.edu ([128.193.4.8]:40381 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S264396AbTLRFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:48:24 -0500
Date: Wed, 17 Dec 2003 21:48:23 -0800 (PST)
From: Krishna Akella <akellak@onid.orst.edu>
X-X-Sender: akellak@shell
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0
In-Reply-To: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0312172144030.31026-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Truly amazing job!!! Bravo!!!

--
Krishna Akella

-----------------------------------------------------------------
They cannot break our spirit, for we do not care if they like us. They
cannot run us out of business, for it is our passion not our livelihood.
They cannot deceive us, because it is in the open. They cannot lie about
us, for we hide nothing. They cannot fight us, for we are legion...

		--Courpus_Callosum. On Open Software.
-----------------------------------------------------------------

On Wed, 17 Dec 2003, Linus Torvalds wrote:

>
> 				"The beaver is out of detox"
> 						- Anon
>
> This should not be a big surprise to anybody on the list any more, since
> we've been building up to it for a long time now, and for the last few
> weeks I haven't accepted any patches except for what amounts to fairly
> obvious one-liners.

> To give you an example, one of the nastier bugs that we chased for the
> last five weeks was a bug that could only be reproduced reliably on a
> 16- or 32-way system, and only when the system had flaky disks. Putting in
> known-good disks made the problem disappear. Similarly, compiling the
> kernel with another compiler made the problem disappear.
>
> It turned out to be a really subtle bug wrt SMP ordering and stack
> allocation, and lots of thanks to Ram Pai for gathering all the
> information that eventually led to it being fixed. The fix was a one-liner
> and a big comment - but my point is that the quality of bugs has been
> pretty high lately, and we feel that we're in pretty good shape.

>
> 		Linus
>
> ---

