Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTIIB50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTIIB50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:57:26 -0400
Received: from [212.28.208.94] ([212.28.208.94]:38929 "HELO www.dewire.com")
	by vger.kernel.org with SMTP id S263547AbTIIB5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:57:25 -0400
From: Robin Rosenberg <robin.rosenberg@dewire.com>
To: Timothy Miller <miller@techsource.com>,
       David Lang <david.lang@digitalinsight.com>
Subject: Re: Use of AI for process scheduling
Date: Tue, 9 Sep 2003 03:57:08 +0200
User-Agent: KMail/1.5.3
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081651220.22562-100000@dlang.diginsite.com> <3F5D2007.5030500@techsource.com> <200309090340.31735.robin.rosenberg@dewire.com>
In-Reply-To: <200309090340.31735.robin.rosenberg@dewire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309090357.08649.robin.rosenberg@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tisdag 09 september 2003 03:40 skrev Robin Rosenberg:
> A rule-based system can be evaluated quite efficiently if the numer of
> rules are reasonable small. A PC can a million of "LIPS" (logical
> Inferences per second so you can fit something useful. Say you can afford
> (on average one percent of the CPU, that becomes 10000 inferences per
> second available per second and with 50 switches pers second that is 2000
Math oops, That makes 200 inferences per secons. Probably still more than needed
but the margin is not that huge.

> inferences per switch. I think can do useful rules with much fewer
> inferences. The numbers are guestimates from memory and a few quick googles
> lookups.

-- robin

