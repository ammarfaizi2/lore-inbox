Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268047AbTGRHwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTGRHwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:52:16 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:31920 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S268047AbTGRHwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:52:15 -0400
Date: Fri, 18 Jul 2003 01:06:27 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718080626.GH19891@ca-server1.us.oracle.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Andrew Morton <akpm@osdl.org>, miquels@cistron.nl,
	linux-kernel@vger.kernel.org
References: <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com> <20030718011115.A2600@pclin040.win.tue.nl> <20030718000444.GG19891@ca-server1.us.oracle.com> <20030718030558.B2612@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718030558.B2612@pclin040.win.tue.nl>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 03:05:58AM +0200, Andries Brouwer wrote:
> There is no flag day. The kernel must be updated, glibc must be
> updated, user space software must be updated. A long process
> that will take years. Indeed, so far we have not succeeded in
> updating the kernel, and eight years went by.

	Yes, software must be updated.  Why on earth would you update it
twice when once will do?

> Filesystems? Last I looked reiserfs handled 32 bits.

	And you treat it as having 16bits until reiser4 or reiser5
handles 64bits.

Joel

-- 

"Under capitalism, man exploits man.  Under Communism, it's just 
   the opposite."
				 - John Kenneth Galbraith

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
