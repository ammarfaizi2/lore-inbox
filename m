Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTKKQjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTKKQjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:39:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29702 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263598AbTKKQjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:39:23 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: aacraid
Date: 11 Nov 2003 16:28:48 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bor2o0$c55$1@gatekeeper.tmr.com>
References: <200311111450.57432.m.watts@eris.qinetiq.com>
X-Trace: gatekeeper.tmr.com 1068568128 12453 192.168.12.62 (11 Nov 2003 16:28:48 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311111450.57432.m.watts@eris.qinetiq.com>,
Mark Watts  <m.watts@eris.qinetiq.com> wrote:

| Are there any utilities available to query the aacraid driver for the status 
| of its arrays? I've noticed messages get put into the syslog when drives 
| fail, but it wouold be nice to get more info from the driver about its 
| arrays.

For 2.4 there's the ipssend command, I doubt that IBM has ported it to
2.6, but whatever made it not work may be fixed, I haven't tried it in
some months, do try it yourself.

If this is useful info, please post back here the results. I have about
30 machines using this hardware, but none on which I can try a 2.6
kernel any more.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
