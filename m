Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTEGOTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTEGOTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:19:39 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:22438 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263219AbTEGOTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:19:33 -0400
Date: Wed, 07 May 2003 08:31:45 +0000
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <40920000.1052296305@caspian.scsiguy.com>
In-Reply-To: <20030507032226.4AEC833266E@oceanic.wsisiz.edu.pl>
References: <20030507032226.4AEC833266E@oceanic.wsisiz.edu.pl>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <2274070000.1051897888@aslan.btc.adaptec.com> you wrote:
>>> I thought it was an sr problem, but it doesn't seem to show up on
>>> anything other than adaptec controllers?  Thanks.
>>
>> I've just updated the bug.
>
> Have You updated it on page too?

I can't parse that.  I added some text to the bug tracker.  This
bug doesn't appear to be a driver issue, so no source changes were made.

> During running slocate/updatedb:
>
> bash-2.05b$ uptime
> 05:07:28  up 1 day,  8:09,  4 users,  load average: 67.07, 30.93, 12.51
>                                                     ^^^^^^^^^^^^^^^^^^^

Which doesn't really tell me much.  What processes are chewing CPU time.
Is it system time?  What kernel version are you using and do you see this
without even using the latest driver?

--
Justin

