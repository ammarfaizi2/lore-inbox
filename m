Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTICPFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbTICPFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:05:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56845 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262830AbTICPFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:05:40 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Quota Hash Abstraction 2.6.0-test2
Date: 3 Sep 2003 14:56:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj4vfq$6to$1@gatekeeper.tmr.com>
References: <20030731184341.GA21078@www.13thfloor.at>
X-Trace: gatekeeper.tmr.com 1062601018 7096 192.168.12.62 (3 Sep 2003 14:56:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030731184341.GA21078@www.13thfloor.at>,
Herbert =?iso-8859-1?Q?P=F6tzl?=  <herbert@13thfloor.at> wrote:

Is any of this, particularly the work mentioned in the last paragraph
getting into the mail kernel?

| Last time I posted the Quota Hash Abstraction for 2.4
| somebody suggested doing it for 2.6, because it "might
| be interesting", so I thought, give it a try, and here
| it is ...
| 
| please, if somebody has any quota tests, which he/she
| is willing to do on this code, or just want to do some
| testing with this code, do it and send me the results ...
| 
| this patch requires the quota fix done by Jan Kara, 
| otherwise quota would not work at all ... 
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
