Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbTGFHdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbTGFHdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:33:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20753 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266633AbTGFHdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:33:38 -0400
Date: Sun, 6 Jul 2003 08:47:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernardo Innocenti <bernie@develer.com>, Ian Molton <spyro@f2s.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030706084750.B8146@flint.arm.linux.org.uk>
Mail-Followup-To: Bernardo Innocenti <bernie@develer.com>,
	Ian Molton <spyro@f2s.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@digeo.com>
References: <200307060133.15312.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307060133.15312.bernie@develer.com>; from bernie@develer.com on Sun, Jul 06, 2003 at 01:33:15AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 01:33:15AM +0200, Bernardo Innocenti wrote:
> Hello everybody,
> 
> second iteration of the div64.h cleanup + bug fixing.
> Contains the following changes since the previous release:

arm26 is Ian Molton.  Please copy Ian on ARM26 matters, not myself.
Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

