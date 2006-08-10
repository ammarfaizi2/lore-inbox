Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161295AbWHJO7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbWHJO7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWHJO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:59:00 -0400
Received: from fysh.org ([83.170.75.51]:52098 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S1161295AbWHJO7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:59:00 -0400
Date: Thu, 10 Aug 2006 15:58:57 +0100
From: Athanasius <link@miggy.org>
To: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       matti.aarnio@zmailer.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060810145857.GI2242@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Willy Tarreau <w@1wt.eu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andi Kleen <ak@suse.de>, Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	matti.aarnio@zmailer.org
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com> <p73y7tzo4hl.fsf@verdi.suse.de> <1155047956.5729.68.camel@localhost.localdomain> <20060808191631.GF8776@1wt.eu> <1155068717.26338.100.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155068717.26338.100.camel@mindpipe>
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:25:16PM -0400, Lee Revell wrote:
> On Tue, 2006-08-08 at 21:16 +0200, Willy Tarreau wrote:
> > On Tue, Aug 08, 2006 at 03:39:16PM +0100, Alan Cox wrote:
> > > Only if applied without imagination.
> > > 
> > > Tag subject lines from non subscribes with [nonsub] and everyone can
> > > then decide for themselves.
> > 
> > This looks like a very clever yet simple idea (if easy to implement at all) !
> > While I have no anti-spam and am not annoyed at all by the low spam rate on
> > LKML, I think this would make my cleaning operations even more effective.
> 
> That would mean 8 fewer characters of useful information visible in the
> subject line.

  There's no reason not to put that tag at the END of the subjectline.
Of course I'm assuming automatic filtering based on it.  Although in
that case it could as easily be a X-NonSub: Yes header.

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
