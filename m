Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVL0NA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVL0NA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 08:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVL0NA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 08:00:26 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:28490 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751105AbVL0NA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 08:00:26 -0500
Date: Tue, 27 Dec 2005 13:29:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/1] Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20051227122948.GA15199@mars.ravnborg.org>
References: <20051221203601.GB20619@lnx-holt.americas.sgi.com> <20051221202356.GA31487@mars.ravnborg.org> <20051221220251.GA2924@lnx-holt.americas.sgi.com> <20051226215542.GA31261@mars.ravnborg.org> <20051227123849.GA4535@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227123849.GA4535@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 06:38:49AM -0600, Robin Holt wrote:
> 
> Thanks.  When do you think that will be applied to Linus' tree?

When 2.6.16 opens up. I have not planned to push to get it into
2.6.15-rc since noone but you have noticed.
And also the change of bison/flex version deserve a bit wider testing.

	Sam
