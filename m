Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVFWVWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVFWVWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVFWVWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:22:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51644 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262709AbVFWVTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:19:14 -0400
Message-ID: <42BB2749.1020209@pobox.com>
Date: Thu, 23 Jun 2005 17:19:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix
References: <42BA7FB5.5020804@pobox.com> <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> hmm, I know I'm not that experianced with patch, but when I saved this 
> to a file and did patch -p1 <file the hunk was rejected, the reject file 
> is saying

It's probably the whitespace thing that Linus's git-apply gadget was 
complaining about.

I'm terribly surprising, though, since my patch(1) applied the diff just 
fine.

<shrug>

	Jeff



