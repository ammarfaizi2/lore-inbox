Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTJAUa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTJAUa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:30:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34057 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262507AbTJAUa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:30:56 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 1 Oct 2003 20:21:25 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blfd05$ipr$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <16250.38688.152166.875893@gargle.gargle.HOWL> <20031001115248.GC23819@compsoc.man.ac.uk>
X-Trace: gatekeeper.tmr.com 1065039685 19259 192.168.12.62 (1 Oct 2003 20:21:25 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031001115248.GC23819@compsoc.man.ac.uk>,
John Levon  <levon@movementarian.org> wrote:
| On Wed, Oct 01, 2003 at 10:58:08AM +0200, Mikael Pettersson wrote:
| 
| > Linus' 2.6.0-test6 announcement doesn't seem to mention the
| > fact that 2.6.0-test5-bk9 fundamentally changed the semantics
| > of /proc/self and the /proc/<pid> name space. These used to
| 
| Are these Albert Calahan's changes ?
| 
| For some reason I can't fathom they were sent privately to Linus without
| them first being posted publicly anywhere ...

I thought there had been discussion a while ago, but I can't put my
finger on it. In any case, I think the OP was noting that it was a
fairly impactful (is that a word?) change not to get a line in the
changelog. That's directed to whoever actually prepares the CL, not the
author of the patch.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
