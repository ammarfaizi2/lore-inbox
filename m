Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUBOWfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUBOWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:35:23 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:13221 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265256AbUBOWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:35:18 -0500
Message-ID: <402FF424.4050902@uchicago.edu>
Date: Sun, 15 Feb 2004 16:35:16 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Micah Anderson <micah@riseup.net>, linux-kernel@vger.kernel.org
Subject: Re: stable/vanilla+(O)1
References: <1pCCK-5S4-23@gated-at.bofh.it>
In-Reply-To: <1pCCK-5S4-23@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micah Anderson wrote:
> Is there a patch to the stable/vanilla 2.4 kernel tree which provides
> the O(1) scheduler code from 2.6? The closest thing I can find is:
> 
> http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0
> 
> which is for AC (and is also A0), is there a newer 2.4.23/24 patch
> that works against stock? The above patch fails miserably against a
> stock 2.4.22 kernel.
> 
> There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/
> the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
> fails horribly on a stock 2.4.22.
> 
> I've been crawling through list archives, but have yet to find
> anything, so I am reduced to asking. :)

The -ck patchset has this and numerous other fun things in it. It can be
found at http://www.plumlocosoft.com/kernel/ .

-- 
Ryan Reich
ryanr@uchicago.edu
