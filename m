Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSHMQuB>; Tue, 13 Aug 2002 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318973AbSHMQuB>; Tue, 13 Aug 2002 12:50:01 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39429 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318990AbSHMQuA>; Tue, 13 Aug 2002 12:50:00 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: RE:Re: The spam problem.
Date: 13 Aug 2002 16:47:40 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ajbd7c$ala$1@gatekeeper.tmr.com>
References: <20BF5713E14D5B48AA289F72BD372D6821CB15@AUSXMPC122.aus.amer.dell.com> <20020813064215.GZ32427@mea-ext.zmailer.org>
X-Trace: gatekeeper.tmr.com 1029257260 10922 192.168.12.62 (13 Aug 2002 16:47:40 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020813064215.GZ32427@mea-ext.zmailer.org>,
Matti Aarnio  <matti.aarnio@zmailer.org> wrote:

|   Quite so.  We don't aim for 100% blocking, we can tolerate a few
|   leaking thru each month.  A few each day would be too much.
| 
|   I have been monitoring what our filters do catch;  sometimes
|   there are things I prefer not to be captured, which means we
|   have to fine-tune the filters a bit..  I am also sometimes
|   (rarely) sending a note to the message originators that their
|   traffic is being captured.

If you have a human to do a little of the work, you can build filters to
do a three category triage; pass, fail, and human review. This allows
the filters to be be MUCH tighter, but assumes 7*24 moderation of some
sort.

Not a recommendation, just a thought. I have this set up on lists and
posting hosts, and it works reasonably well, taking about five minutes a
few times a day on the weekend.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
