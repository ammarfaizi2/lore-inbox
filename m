Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLPTMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTLPTMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:12:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64522 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262052AbTLPTMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:12:37 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Device-mapper submission for 2.4
Date: 16 Dec 2003 19:01:08 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brnkpj$tl$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
X-Trace: gatekeeper.tmr.com 1071601268 949 192.168.12.62 (16 Dec 2003 19:01:08 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>,
Paul Jakma  <paul@clubi.ie> wrote:

| I'd really like to see one of:
| 
| - backwards compat: 2.6 have LVM1 support
| 
| - forward compat: 2.4 to have DM support to allow 2.4 users to 
| migrate
| LVM->DM first /before/ taking the risk on running 2.6.

Hate to say it, but unlike XFS which has been available for 2.4 for ages
and very well tested, DM for 2.4 has all the joy of a newly posted
feature. I really think that you will find the *if* you want DM you will
be safer going to 2.6 and using the version which has been reasonably
well tested.

You will want to do a full backup before going to a new o/s in any case,
if your data is of value.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
