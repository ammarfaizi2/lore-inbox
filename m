Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUJYGNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUJYGNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUJYGNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:13:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38023 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261521AbUJYGMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:12:49 -0400
Message-ID: <417C9955.4030507@pobox.com>
Date: Mon, 25 Oct 2004 02:12:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serious stability issues with 2.6.10-rc1
References: <pan.2004.10.25.01.20.55.763270@triplehelix.org>
In-Reply-To: <pan.2004.10.25.01.20.55.763270@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> Hello,
> 
> 2.6.10-rc1 seems to have a tendency to lock up after about 8 hours or so
> of uptime. Usually, I am in X, listening to music, and working on
> something when this happens out of the blue. It's a hard hang and there is
> no network response or ability to switch back to a tty so i can get
> sysrq-t output. It just dies. This has happened twice in the past 48 or
> so hours.
> 
> I can't really provide much debugging info though, due to the nature of
> the hang. Is there anything that pops into mind that I should try to nail
> this problem?
> 
> 2.6.9 seems to be a lot better at staying alive.


Could you please search through the various 2.6.9-bk snapshots, to see 
where this behavior starts?

	Jeff


