Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbRBDEc5>; Sat, 3 Feb 2001 23:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131263AbRBDEcr>; Sat, 3 Feb 2001 23:32:47 -0500
Received: from dsl-45-165.muscanet.com ([208.164.45.165]:1955 "EHLO grace")
	by vger.kernel.org with ESMTP id <S130210AbRBDEcg>;
	Sat, 3 Feb 2001 23:32:36 -0500
Date: Sat, 3 Feb 2001 22:32:36 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] Major Clock Drift
Message-ID: <Pine.LNX.4.21.0102032225240.8663-100000@grace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I know this _really_ isn't the forum for this, but a friend of mine has
noticed major, persistent clock drift over time. After several weeks, the
clock is several minutes slow (always slow). Any thoughts on the
cause? (Google didn't show up anything worthwhile in the first couple of
pages, so i gave up).

I assume it doens't matter what the mains frequency is (since we're
pulling from a crystal for this anyway). I think i'd heard mention of
problems with other interrupts interrupting the timer often enough that
the time got slowed down, but really?

It's a relatively new Athlon, not sure of the mobo model. If it is a
hardware problem, i'll find out the model, since that would strike me as
an errata =)

Thanks for indulging an idle hardware question
--
/jbm, but you can call me Josh. Really, you can.
  Rap-Rock is neither Modern nor Alternative.
             Not that I'm bitter.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
