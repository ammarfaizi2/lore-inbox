Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTEOAgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTEOAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:36:41 -0400
Received: from mail.webmaster.com ([216.152.64.131]:24795 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263258AbTEOAgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:36:39 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Chris Siebenmann" <cks@utcc.utoronto.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: The disappearing sys_call_table export.
Date: Wed, 14 May 2003 17:49:23 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAELMCPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200305141928_MC3-1-38F1-60EC@compuserve.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Chris Siebenmann wrote:

>   Many of these decisions are made by Dumb White Guys sitting around
> a boardroom table looking at feature lists, and pushed by even dumber
> 3-letter consulting firms whose technical representatives say things
> like "Yes, we will be decrypting all SSL sessions at the firewall to
> check for viruses."

>   So I think Linux needs these 'fringe' features if it's going to
> continue to expand its user base in the face of such stupidity.

	I, for one, completely disagree in the strongest way possible. This whole
argument style rings entirely hollow with me. I'd much rather say, "We don't
do that because it's stupid. We will gladly explain to you why we think it's
stupid, what you really want, and how to get that from us."

	Deliberately designing in misfeatures so that dumb people will get what
they think they want is architectural suicide. I hope Linux never moves in
that direction.

	It's better to refuse to do things until and unless you're totally
convinced they are the right thing to do. That way, people know that
anything you've done is right.

	There will always be some friction between those who want to see Linux run
by as many people and machines as possible and those who think various other
things are more important. I'm squarely in the "make the best possible OS"
camp. If people don't want to run it, that's their loss.

	DS


