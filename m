Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSGSTz0>; Fri, 19 Jul 2002 15:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSGSTz0>; Fri, 19 Jul 2002 15:55:26 -0400
Received: from e.kth.se ([130.237.48.5]:54022 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316997AbSGSTzZ>;
	Fri, 19 Jul 2002 15:55:25 -0400
To: Rob Landley <landley@trommello.org>
Cc: CaT <cat@zip.com.au>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
	<20020718213857.E23208@work.bitmover.com>
	<20020719044518.GK5608@zip.com.au>
	<200207190532.g6J5Wia87042@pimout3-int.prodigy.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 19 Jul 2002 21:58:27 +0200
In-Reply-To: Rob Landley's message of "Thu, 18 Jul 2002 19:34:24 -0400"
Message-ID: <yw1xbs9332xo.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> On Friday 19 July 2002 12:45 am, CaT wrote:
> > On Thu, Jul 18, 2002 at 09:38:57PM -0700, Larry McVoy wrote:
> > > On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> > > > I've been sitting on this question for years, hoping I'd come
> > > > across the answer, and I STILL don't know what the "i" is short for.
> > > > Somebody here has got to know this. :)
> > >
> > > Incore node, I believe.  In the original Unix code there was dinode and
> > > inode if I remember correctly, for disk node and incore node.
> >
> > That's a new one. I always thought it was 'information node' so in the
> > above it'd be disk information node and just information node.
> >
> > Makes sense to me in any case. :)
> 
> So far I've also received off-list mails saying that it stands for
> "index" (this person cited "the design of the unix operating
> system", by Maurice J Bach, which I have on my shelf but don't
> remember that bit from), and another vote for "indirection" from
> somebody I recognize as being on this list longer than I have...

Andrew S. Tanenbaum claims it's index nodes in 'Modern Operating
Systems, 2nd ed.'. He also wants them spelled i-node.

-- 
Måns Rullgård
mru@users.sf.net
