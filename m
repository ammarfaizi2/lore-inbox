Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTLCW70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTLCW70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:59:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33803 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262108AbTLCW7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:59:21 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 22:48:11 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlp7b$k9c$1@gatekeeper.tmr.com>
References: <bqlhuv$jh2$1@gatekeeper.tmr.com> <20031203230716.247fa67d.grundig@teleline.es>
X-Trace: gatekeeper.tmr.com 1070491691 20780 192.168.12.62 (3 Dec 2003 22:48:11 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203230716.247fa67d.grundig@teleline.es>,
grundig@teleline.es <grundig@teleline.es> wrote:
| El 3 Dec 2003 20:44:15 GMT davidsen@tmr.com (bill davidsen) escribió:
| 
| > 
| > Linus accepted it for 2.6, does it need to be blessed by the Pope, or what?
| 
| Linus accepted _many_ things in 2.6 ;)

That's a good thing! And there's a start at being able to disable more
thing for embedded use, which is also a good thing.
| 
| > Now that is bullshit and you know it! This is not a pet feature, this
| > is code which has has been stable for years. There just aren't any
| > other candidates, all the other FS stuff went in with less testing and
| > have fewer users now (JFS as example). This is also not code offered
| 
| Not only Fs's, the entire vm got replaced and the fact that was made
| doesn't mean it was right.

I just don't buy the implication that that this would lead to other
major things coming in, there aren't any I can think of with the track
record of XFS. And it's not coming in just before the freeze, it's been
trying to come in for several years.
| 
| AFAICT, Marcelo isn't taking any decision that would unstabilize the stable
| tree. I'm happy with that. He isn't taking other things which are _far_
| more importante for people, ALSA for example (drivers that you can just
| disable. And it doesn't touch VFS code) and _nobody_ cares abouth
that.

Well I sure don't care about ALSA, but I'm not a gamer and a few decades
of competitive target shooting, even with ear protection, have reduced
my audio needs to the point that the cars which are supported work for
me, my cat can listen in better fidelity on his Paw Pilot if he wants to.
| 
| (Personally I don't think Marcelo would refuse XFS if it wouldn't touch
| the VFS code. The fact that some people think Marcelo is refusing it because
| he doesn't likes the code is stupid - he made clear that the problem
| is the VFS related part)
| 
| Hopefully hch will review it, he will agree that it's
| right, or he will find bugs that nobody has triggered with the xfs patches,
| and xfs will be merged and all this fscking flame will stop

If there were show stopper technical issues, they were there years ago,
and the answer should have been NO then instead of "not in this
relese." After all this I can see that no one wants to stick their neck
out and bless something which the maintainer doesn't want; if there is a
problem the whining would never end.

I guess it's perception, it looks as if XFS got passed over by newer
and less tested FSs, it feels to some people as if the XFS group was
led to believe that if they worked long and hard enough it would be
accepted, and that leads to complaints.

People will get over it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
