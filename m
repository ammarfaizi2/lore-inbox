Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVEYNf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVEYNf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVEYNf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:35:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34260 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262345AbVEYNeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:34:23 -0400
Message-ID: <42947ED9.9040401@pobox.com>
Date: Wed, 25 May 2005 09:34:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: Juerg Billeter <juerg@paldo.org>, linux-kernel@vger.kernel.org
Subject: Re: Broken nForce2 IDE module loading via hotplug
References: <DBFABB80F7FD3143A911F9E6CFD477B00604C7BE@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00604C7BE@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> Actually, it occurred to me that it would be better if the determination
> to use the generic entry can be run-time specified (via a kernel option
> flag, for example).  All the kernel config option accomplishes is a
> cleaner way to disable the generic entry at compile time.
> 
> In any case, it'd be interesting to figure out the EXACT root of the
> problem.  Let me spend a few days looking into it.

Any progress?


