Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTLKBzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLKBzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:55:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62220 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264386AbTLKBxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:53:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test11-wli-1
Date: 11 Dec 2003 01:42:00 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br8i18$v8s$1@gatekeeper.tmr.com>
References: <20031209233523.GS8039@holomorphy.com> <Pine.LNX.4.58.0312091859330.2313@montezuma.fsmlabs.com>
X-Trace: gatekeeper.tmr.com 1071106920 32028 192.168.12.62 (11 Dec 2003 01:42:00 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312091859330.2313@montezuma.fsmlabs.com>,
Zwane Mwaikambo  <zwane@arm.linux.org.uk> wrote:
| On Tue, 9 Dec 2003, William Lee Irwin III wrote:
| 
| > On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
| > > Successfully tested on a Thinkpad T21. Any feedback regarding
| > > performance would be very helpful. Desktop users should notice top(1)
| > > is faster, kernel hackers that kernel compiles are faster, and highmem
| > > users should see much less per-process lowmem overhead.
| >
| > Bill Davidsen reported an issue where compiled kernel images aren't
| > properly distinguished from mainline kernels' by installation scripts.
| >
| > The following patch should resolve this:
| 
| Argh, i've been screaming about this for ages...

Look, I'm a big boy now, I should be smart enough to *check* this,
because every once in a while other people (you know who you are) do it
too. My fault, I just noted it because other people may not be backed up
as well as I am and shoot their only working kernel.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
