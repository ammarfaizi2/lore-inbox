Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTJNDwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 23:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTJNDwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 23:52:05 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55052 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261615AbTJNDwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 23:52:03 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test7-netx1
Date: 14 Oct 2003 03:42:14 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bmfral$vd3$1@gatekeeper.tmr.com>
References: <20031009155302.4f2fe835.shemminger@osdl.org> <20031010014822.0130ca61.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1066102934 32163 192.168.12.62 (14 Oct 2003 03:42:14 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031010014822.0130ca61.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
| On Thu, 9 Oct 2003 15:53:02 -0700
| Stephen Hemminger <shemminger@osdl.org> wrote:
| 
| >     * TCP Vegas (from Dave Miller)
| 
| Please don't use a config option for this, that is why the
| sysctl is there and off by default.

What is it with people wanting their features forced into kernels which
don't need them? First the Athlon bugfix patch, now this. There are
people out here who would like to use 2.6 kernels in small (possibly
embedded) applications.

I have nothing against any of these features, but if they aren't needed
they are just bloat. Please don't oppose making features configurable.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
