Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266042AbUGAQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUGAQna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUGAQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:43:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:49086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266042AbUGAQn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:43:29 -0400
Date: Thu, 1 Jul 2004 09:43:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <20040701162328.GK15086@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0407010926090.11212@ppc970.osdl.org>
References: <200407010706.i6176pTa019793@magilla.sf.frob.com>
 <Pine.LNX.4.58.0407010843450.11212@ppc970.osdl.org> <20040701162328.GK15086@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Andrea Arcangeli wrote:
> 
> That's why I admitted it can be considered a feature and not a
> completely worthless effort to leave self-reaping tasks as zombies if
> they're ptraced.

Hey, if you both agree, I'm not going to complain. Applied.

		Linus
