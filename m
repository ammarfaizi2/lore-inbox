Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWBYXKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWBYXKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 18:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWBYXKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 18:10:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58295 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750710AbWBYXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 18:10:14 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4400E34B.1000400@s5r6.in-berlin.de>
Date: Sun, 26 Feb 2006 00:07:55 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: stable@kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org>
In-Reply-To: <20060225021009.GV3883@sorel.sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.713) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
>>sd: fix memory corruption by sd_read_cache_type
> 
> Looks like these still aren't upstream.  Can you please resend to -stable
> once they've been picked up by Linus?

Yes, I will do so.
-- 
Stefan Richter
-=====-=-==- --=- ==-=-
http://arcgraph.de/sr/
