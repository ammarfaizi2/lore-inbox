Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTIEDup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTIEDup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:50:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34821 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261952AbTIEDuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:50:44 -0400
Date: Thu, 4 Sep 2003 23:41:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy v10
In-Reply-To: <20030904232752.GA4102@matchmail.com>
Message-ID: <Pine.LNX.3.96.1030904233834.20419B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Mike Fedyk wrote:

> On Thu, Sep 04, 2003 at 10:55:40PM +0000, Bill Davidsen wrote:
> > I'll be switching back and forth for a bit, and I have no working sound,
> > 2.6.0-test4 just doesn't like the old Soundblaster, which works with
> > Redhat 2.4.18 whatever from RH 7.3 install. I'm trying to get a clean
> > oops to report when loading the aha152x module, and I want to generate
> > it without *any* patches, in case someone ever cares. Other than that I
> 
> I was able to generate the oops on one of my systems, and Andrew already
> included a patch that works for me in test4-mm4.

Thanks for the pointer! Tomorrow I will get to test test4-mmX vs. plain
test-+NickV10. There is an aweful lot of scheduler development going on...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

