Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVAYXkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVAYXkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVAYXkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262226AbVAYXPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:15:14 -0500
Date: Tue, 25 Jan 2005 15:15:08 -0800
Message-Id: <200501252315.j0PNF8tL014049@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: george@mvista.com
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
In-Reply-To: George Anzinger's message of  Monday, 24 January 2005 18:31:14 -0800 <41F5AF72.8000502@mvista.com>
X-Zippy-Says: HUMAN REPLICAS are inserted into VATS of NUTRITIONAL YEAST...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Possibly you could bury these name changes in defines.  I suspect the
> code would be easier to read and that we really don't need to be reminded
> that it is a union on each reference.

To be honest, I can never really predict the direction of vitriolic opinion
I'll get on such things.  I'm happy to change it however people prefer.


Thanks,
Roland
