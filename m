Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTIOU5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTIOU5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:57:42 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:17412 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261590AbTIOU5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:57:02 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
References: <m3k78923wy.fsf@lugabout.jhcloos.org>
	<20030915132514.0bee90bc.akpm@osdl.org>
        <20030915134202.A1378@osdlab.pdx.osdl.net>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030915132514.0bee90bc.akpm@osdl.org>
Date: 15 Sep 2003 16:56:54 -0400
Message-ID: <m38yop22jt.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is file_lock_cache only a recent issue, then?  The slowdown has been
going on for at least the last 20 or so release tags.

If this is new I probably need to look at htree or the possibility
that it is a disk firmware issue (it being a laptop and all)....

Thanks for both replies.

-JimC

