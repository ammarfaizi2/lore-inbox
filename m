Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRBDGuS>; Sun, 4 Feb 2001 01:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131473AbRBDGuI>; Sun, 4 Feb 2001 01:50:08 -0500
Received: from relay1.pair.com ([209.68.1.20]:12549 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S131396AbRBDGuC>;
	Sun, 4 Feb 2001 01:50:02 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010204044224.9510.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102032225240.8663-100000@grace>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Josh Myer's message of "Sat, 3 Feb 2001 22:32:36 -0600 (CST)"
Organization: rows-n-columns
Date: 04 Feb 2001 15:42:23 +1100
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Myer <jbm@joshisanerd.com> writes:

> I know this _really_ isn't the forum for this, but a friend of mine has
> noticed major, persistent clock drift over time. After several weeks, the
> clock is several minutes slow (always slow). Any thoughts on the
> cause? (Google didn't show up anything worthwhile in the first couple of
> pages, so i gave up).
> 
> I assume it doens't matter what the mains frequency is (since we're
> pulling from a crystal for this anyway). I think i'd heard mention of
> problems with other interrupts interrupting the timer often enough that
> the time got slowed down, but really?
> 
> It's a relatively new Athlon, not sure of the mobo model. If it is a
> hardware problem, i'll find out the model, since that would strike me as
> an errata =)

Try <http://cr.yp.to/clockspeed.html>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
