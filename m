Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULEKGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULEKGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULEKGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:06:33 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:11442 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261287AbULEKGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:06:32 -0500
Message-ID: <41B2DDA5.20208@triplehelix.org>
Date: Sun, 05 Dec 2004 02:06:29 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: gandalf@wlug.westbo.se, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix ALSA resume
References: <1102195391.1560.65.camel@tux.rsn.bth.se>	<20041204172855.350100d0.akpm@osdl.org>	<41B282F0.3020704@triplehelix.org> <20041204235155.3b8ad3fc.akpm@osdl.org>
In-Reply-To: <20041204235155.3b8ad3fc.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> OK, suspend was failing, yes?

Yes.

> Can you please test Martin's patch?

Works for me.

-- 
Joshua Kwan
