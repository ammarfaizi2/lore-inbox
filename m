Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVDEWHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVDEWHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVDEWFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:05:32 -0400
Received: from orb.pobox.com ([207.8.226.5]:40428 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262045AbVDEWDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:03:30 -0400
Date: Tue, 5 Apr 2005 15:03:21 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405220321.GA5166@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 07:14:45AM -0700, Barry K. Nathan wrote:
> 2.6.11-bk9 works (actually it takes under 2 seconds, not 5-10).
> 2.6.11-bk10 has the weird slowdown.
> 
> I'll see if I can isolate it any further.

2.6.11-mm2 works, but 2.6.11-mm3 has the ridiculously slow resumes.

Later today I'll see if I can narrow things down any further (e.g. to a
specific patch in 2.6.11-mm3 or whatever).

-Barry K. Nathan <barryn@pobox.com>

