Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbTGJX6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269686AbTGJX6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:58:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269649AbTGJX6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:58:06 -0400
Date: Thu, 10 Jul 2003 17:12:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
In-Reply-To: <p73isqaos29.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0307101709360.5091-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003, Andi Kleen wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > Also, the only real point of a stable release is for distribution makers.
> > That pretty much cuts the list of "needs to be supported" down to x86,
> > ia64, x86-64 and possibly sparc/alpha.
> 
> No ppc, ppc64, s390?

Do we have distributions that intend to make releases using those? I
suspect not, but hey, don't get me wrong: I'd love to see them working
out-of-the-box.

It's purely a matter of priorities. The only architecture that really 
_has_ to be stable is x86. Others are determined largely by whether they 
get their own testing done, and companies and individuals being willing to 
put the resources down.

			Linus

