Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVDEOTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVDEOTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDEOTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:19:54 -0400
Received: from orb.pobox.com ([207.8.226.5]:12215 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261758AbVDEOOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:14:51 -0400
Date: Tue, 5 Apr 2005 07:14:45 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 06:44:08AM -0700, Barry K. Nathan wrote:
> swsusp: reading slkf;jalksfsadflkjas;dlfasdfkl (12345 pages): 34%
> [sorry, I just got up so my short-term memory isn't working that well
> yet]
> 
> takes 10-30 minutes (depending on whether it's closer to 11000 pages or
> 20000) rather than the 5-10 seconds or so that it takes under 2.6.11-ac5
> (or mainline 2.6.11 if I remember correctly).
[snip]
> I'll try to do some more testing to see (a) when this problem started
> and (b) whether it still exists in 2.6.12-rc2 or later. This is going to
> be ridiculously difficult for me to fit into my schedule right now, but
> I'll try....

2.6.11-bk9 works (actually it takes under 2 seconds, not 5-10).
2.6.11-bk10 has the weird slowdown.

I'll see if I can isolate it any further.

-Barry K. Nathan <barryn@pobox.com>

