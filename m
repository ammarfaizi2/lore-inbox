Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTJUWCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTJUWCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:02:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37892 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263418AbTJUWCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:02:04 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Software RAID5 with 2.6.0-test
Date: 21 Oct 2003 21:51:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn49pv$jbn$1@gatekeeper.tmr.com>
References: <20031018115049.GB760@gallifrey>
X-Trace: gatekeeper.tmr.com 1066773119 19831 192.168.12.62 (21 Oct 2003 21:51:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031018115049.GB760@gallifrey>,
Dr. David Alan Gilbert <gilbertd@treblig.org> wrote:

|   I'd love to see some real benchmarks to prove me wrong however!

Okay, I'm scheduled to build a system next month, give me the name of a
good controller which will do four drives and which can be used as a
dumb controller as well, and I'll grab six drives for the build and run
a test (baring a change in schedule, obviously).

I'll run as many RAID configs as make sense, whatever the hardware
supports. And also four way RAID-1 for a heavy read application, to see
if the software RAID does better than the controller, if it can do that
at all.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
