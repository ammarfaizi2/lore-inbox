Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbTIDX1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTIDX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:27:52 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1040
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262208AbTIDX1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:27:51 -0400
Date: Thu, 4 Sep 2003 16:27:52 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy v10
Message-ID: <20030904232752.GA4102@matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <3F5044DC.10305@cyberone.com.au> <bj8ftc$ikl$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bj8ftc$ikl$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:55:40PM +0000, Bill Davidsen wrote:
> I'll be switching back and forth for a bit, and I have no working sound,
> 2.6.0-test4 just doesn't like the old Soundblaster, which works with
> Redhat 2.4.18 whatever from RH 7.3 install. I'm trying to get a clean
> oops to report when loading the aha152x module, and I want to generate
> it without *any* patches, in case someone ever cares. Other than that I

I was able to generate the oops on one of my systems, and Andrew already
included a patch that works for me in test4-mm4.
