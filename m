Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272910AbTG3ORZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTG3ORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:17:24 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:34756 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272910AbTG3ORF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:17:05 -0400
Date: Wed, 30 Jul 2003 07:16:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK2CVS up to date
Message-ID: <20030730141647.GA21513@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	M?ns Rullg?rd <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20030730124515.GA19748@work.bitmover.com> <yw1xispknohi.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xispknohi.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 03:16:57PM +0200, M?ns Rullg?rd wrote:
> Larry McVoy <lm@bitmover.com> writes:
> 
> > There was a pause in the updating of the 2.5 CVS tree exported from the
> > 2.5 BK tree; it was related to the move to the new colo.  The trees are
> > up to date now and I suspect that Ben's BK2SVN mirror will be updated
> > soon as well.
> 
> That reminds me that (last time I checked (last week)) the CVS tag for
> 2.4.21 was missing.  There's only a tag for 2.4.21-pre8, which is
> equal to 2.4.21, but, IMHO, the final version should have a tag.

$ rlog ChangeSet,v | more

RCS file: ChangeSet,v
Working file: ChangeSet
head: 1.3660
branch:
locks: strict
access list:
symbolic names:
        v2_4_22-pre8: 1.3645
        v2_4_22-pre7: 1.3621
        v2_4_22-pre6: 1.3577
        v2_4_22-pre5: 1.3538
        v2_4_22-pre1: 1.3211
        v2_4_21: 1.3190
...
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
