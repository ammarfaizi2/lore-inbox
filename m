Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161471AbWI2Hb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWI2Hb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWI2Hb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:31:29 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:52147 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161471AbWI2Hb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:31:28 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tridge@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17692.46192.432673.743783@samba.org>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.46192.432673.743783@samba.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 00:31:25 -0700
Message-Id: <1159515085.3880.78.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 15:51 +1000, tridge@samba.org wrote:
> I am however disagreeing with the justification given in the position
> statement. The position statement implies that the FSF may be in
> breach of contract, at least morally, by trying to release a version
> of the GPL that is not in keeping with previous versions. I think the
> preamble of the GPLv2 and the explanations given of the FSF intentions
> over the years are completely consistent with the GPLv3 current draft.

Right ... see the semantic argument over the difference between use and
distribution I gave Neil a while ago.

The FSF has always maintained (and still does) that you can use the
covered work for anything (although the v2 language saying this is gone
in v3).  I believe even the FSF accepts the position that reaching
beyond distribution to control end use would be a violation of the
spirit of GPLv2 .... if they didn't we wouldn't be quibbling over the
semantic meanings of the two terms.  Their latest press release on this
actually says "Contrary to what some have said, the GPLv3 draft has no
use restrictions, and the final version won't either."

> ok, lets take a really obvious example. Say that HP decided to
> incorporate modified parts of the Linux kernel in HPUX on in their
> printers. HP would be distributing the resulting image for people to
> use. The fact that people are 'using' it in the end does not alter the
> fact that HP would be in violation of the GPL during the act of
> distribution.

That's correct.  They have to comply with the distribution duties as
outlined in the licence (which they could do by publishing all of the
HPUX pieces they incorporated, of course).  However, once they comply
with the distribution requirements, they're free to do whatever they
want with the resulting OS in their printer ... including checking for
only HP authorised ink cartridges.  You can take exception to this check
and not buy the resulting printer, but you can't tell them not to do the
check without telling them how they should be using the embedded
platform.

James


