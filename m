Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTICEDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 00:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTICEDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 00:03:33 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:4031 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S261621AbTICEDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 00:03:33 -0400
Date: Tue, 2 Sep 2003 21:03:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Scaling noise
Message-ID: <20030903040327.GA10257@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've frequently tried to make the point that all the scaling for lots of
processors is nonsense.  Mr Dell says it better:

    "Eight-way (servers) are less than 1 percent of the market and shrinking
    pretty dramatically," Dell said. "If our competitors want to claim
    they're No. 1 in eight-ways, that's fine. We want to lead the market
    with two-way and four-way (processor machines)."

Tell me again that it is a good idea to screw up uniprocessor performance
for 64 way machines.  Great idea, that.  Go Dinosaurs!
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
