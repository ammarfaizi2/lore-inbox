Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbULGRby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbULGRby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULGRby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:31:54 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16779 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261866AbULGRbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:31:32 -0500
Message-ID: <41B5E926.7040302@tmr.com>
Date: Tue, 07 Dec 2004 12:32:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ram mohan <madhaviram123@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Contribute - How to 
References: <20041203042003.57961.qmail@web90007.mail.scd.yahoo.com>
In-Reply-To: <20041203042003.57961.qmail@web90007.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ram mohan wrote:
> Hi,
> I am willing to contribute to the development of Linux
> kernel. I googled a bit and found that I should join
> the list and then I can go ahead.
> I would like to know.
> 1. What are the features currently being worked upon?
> 2. Are there any things-to-do lists maintained?

See bugzilla for a list of current problems. Pick one, start small, test 
the fix and submit patches. Alternately if you have any of hardware 
around for which the 2.6 driver is marked broken, you can unbreak it. If 
you do a good job you might become the maintainer for that driver (good 
news/bad news).

> 3. How are new features selected?
> 4. Can I suggest new features?

Usually by someone coding them as proof of concept. However, before 
starting code on anything large, an RFC (req for comments) post may 
reveal someone else solving the problem, or that the cure is worse than 
the problem for some inobvious reason, or that someone important (Linus, 
akpm, DavidM) just doesn't like it even though it works perfectly and 
introduces no new problems.

Good luck, glad to see someone ready to help.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
