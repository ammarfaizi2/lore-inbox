Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUKNLp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUKNLp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 06:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbUKNLp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 06:45:58 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:61930 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261288AbUKNLpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 06:45:54 -0500
Message-ID: <4197455B.4070406@g-house.de>
Date: Sun, 14 Nov 2004 12:45:31 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20041008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com> <20041114025814.GA20342@lists.us.dell.com>
In-Reply-To: <20041114025814.GA20342@lists.us.dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> 
> Alexander van Heukelum noted to me that addw here modifies CF, so I
> think something like should fix that.  Christian, if you're in a
> position to test this, I'd really appreciate it.  You've been a

yes, i'll do so. right now i am off (and late) to sth. else, but i'll 
test this in the evening.

thank you,
Christian.
-- 
BOFH excuse #318:

Your EMAIL is now being delivered by the USPS.
