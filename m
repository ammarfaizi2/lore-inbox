Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUASK04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 05:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUASK04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 05:26:56 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:41487 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S263927AbUASK0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 05:26:55 -0500
Date: Mon, 19 Jan 2004 11:26:48 +0100
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Subject: aacraid and 2.6
Message-ID: <20040119102647.GA23288@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Last week I tried to get aacraid working under 2.6.1, which failed.  In
http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt it
says:

	o ideraid hasn't been ported to 2.5 at all yet.

	  We need to understand whether the proposed BIO split code will suffice
	  for this.

So that explains the non-working part in 2.6. In 2.4.24 is worked out of the
box, so I'm running that now.

My question: is there _any_ ETA on when this stuff is going to work in 2.6?

Could you please CC me on answers? I'm only reading the digest. Thanks,

grtz
      Miek
--
GPG fingerprint: miek.nl/about.html
