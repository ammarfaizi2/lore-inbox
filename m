Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTHLUyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHLUyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:54:51 -0400
Received: from mailout1.echostar.com ([204.76.128.101]:59150 "EHLO
	mailout1.echostar.com") by vger.kernel.org with ESMTP
	id S271112AbTHLUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:54:49 -0400
From: "Pavlica, Nick" <Nick.Pavlica@echostar.com>
Reply-To: "Pavlica, Nick" <nick.pavlica@echostar.com>
To: linux-kernel@vger.kernel.org
Organization: EchoStar Communications
Subject: Swapfile Calculation / 2.4.18 | >
Date: Tue, 12 Aug 2003 14:53:18 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121453.18739.nick.pavlica@echostar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note:
  Please CC answers/comments you post to me.

All,
  Our team is discussing the best approach to calculating the swap file size 
for the 2.4.18 kernels and newer on systems with 6 - 8 Gb of RAM.  Does the 
"Double The System Ram" rule still apply?

I'm sorry if I offend anyone by posting this here, I'm just looking for an 
authoritative / accurate response.

A quote on the topic from one of our engineers:

  "I'd disagree on the Swapfile size.  Swapfiles over 2 Gig are insane.  If
  a host is consuming 2+ Gig of real RAM, and consuming another 2 Gig of
  Swap, something is wrong with the apps that are running on that host.
  (I can go into a big tirade on how Linux VM works, if anyone wants ;) )"


Thanks for your suggestions!

-- 
Nick Pavlica
EchoStar Communications
CAS-Engineering
(307)633-5237
