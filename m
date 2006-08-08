Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWHHKKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWHHKKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWHHKKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:10:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964784AbWHHKKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:10:39 -0400
Date: Tue, 8 Aug 2006 20:10:25 +1000
From: Nathan Scott <nathans@sgi.com>
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is XFS trustworthy in the latest 2.6.16
Message-ID: <20060808201025.A2536447@wobbly.melbourne.sgi.com>
References: <eb9epf$dse$1@sea.gmane.org> <20060808185017.A2528231@wobbly.melbourne.sgi.com> <eb9lp9$3h2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <eb9lp9$3h2$1@sea.gmane.org>; from Manuel.Spam@nurfuerspam.de on Tue, Aug 08, 2006 at 11:34:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 11:34:10AM +0200, Manuel Reimer wrote:
> Nathan Scott schrieb:
> > On Tue, Aug 08, 2006 at 09:34:48AM +0200, Manuel Reimer wrote:
> >> Hello,
> >>
> >> could someone please tell me if XFS is trustworthy in the latest 2.6.16? 
> >> There have been some bugs:
> >>
> >> http://bugzilla.kernel.org/show_bug.cgi?id=6380
> >> http://bugzilla.kernel.org/show_bug.cgi?id=6757
> > 
> > These are the same problem.  2.6.16 is unaffected.
> 
> But the bug has been filed for 2.6.16.4.

Indeed, once the corruption exists ondisk all kernels will detect it.
Read through the entire bug, many details come toward the end.

> Did you want to say, that the latest 2.6.16 is unaffected?

All 2.6.16's are unaffected.

> >> want a stable kernel and 2.6.16 seems to fit all my needs.
> > 
> > For XFS, its goodness.  2.6.18 will be good too, and 2.6.17.7+.
> 
> What exactly did you want to tell with this sentence. Sorry, but my 
> native language is german...

Sorry, I meant to say "theres nothing wrong with 2.6.16".

> Is it a good solution to stay on the 2.6.16 branch? Of course I could 

Yes, thats fine.

cheers.

-- 
Nathan
