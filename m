Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTJFDLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTJFDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:11:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31237 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263961AbTJFDL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:11:29 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 6 Oct 2003 03:01:53 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blqlv1$dhr$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20031001115248.GC23819@compsoc.man.ac.uk> <blfd05$ipr$1@gatekeeper.tmr.com> <20031002010054.GA13639@compsoc.man.ac.uk>
X-Trace: gatekeeper.tmr.com 1065409313 13883 192.168.12.62 (6 Oct 2003 03:01:53 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031002010054.GA13639@compsoc.man.ac.uk>,
John Levon  <levon@movementarian.org> wrote:
| On Wed, Oct 01, 2003 at 08:21:25PM +0000, bill davidsen wrote:
| 
| > finger on it. In any case, I think the OP was noting that it was a
| > fairly impactful (is that a word?) change not to get a line in the
| > changelog. That's directed to whoever actually prepares the CL, not the
| 
| It did get in the changelog (it's automated). It just didn't get sent
| for public review at all.

Actually, while there was an entry for the change, it didn't mention
that there was a major interface rethink. In that particular case I
believe a human should have been in the loop.

Just a comment, not major issue.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
