Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSH1PeP>; Wed, 28 Aug 2002 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSH1PeP>; Wed, 28 Aug 2002 11:34:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318873AbSH1PeP>; Wed, 28 Aug 2002 11:34:15 -0400
Subject: Re: LTP Nightly BK Test Failure
From: Paul Larson <plars@austin.ibm.com>
To: Larry McVoy <lm@bitmover.com>
Cc: lkml <linux-kernel@vger.kernel.org>, scott.feldman@intel.com
In-Reply-To: <20020828081036.B28927@work.bitmover.com>
References: <1030545604.2601.3.camel@plars.austin.ibm.com> 
	<20020828081036.B28927@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 10:28:30 -0500
Message-Id: <1030548511.2602.8.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 10:10, Larry McVoy wrote:
> On Wed, Aug 28, 2002 at 09:40:03AM -0500, Paul Larson wrote:
> > This bk tree covered up to cset 1.523.1.3 and there were several e100
> 
> Because revisions in BK change if there is parallel development, it's
> far more effective if you list a changeset as either
...
I didn't think about that, thanks for the tip.  I'll make sure to do it
like that in future reports.  Of course if there's any confusion, the
cset numbers I've been giving can be looked up on the linux-2.5 tree at
bkbits since I test against an unmodified pull from that tree.

Thanks,
Paul Larson


