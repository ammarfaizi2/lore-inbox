Return-Path: <linux-kernel-owner+w=401wt.eu-S1750958AbXARHsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbXARHsm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbXARHsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:48:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59533 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbXARHsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:48:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Rajat Jain" <rajat.noida.india@gmail.com>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>,
       "Daniel Rodrick" <daniel.rodrick@gmail.com>,
       kernelnewbies <kernelnewbies@nl.linux.org>,
       "Linux Newbie" <linux-newbie@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: after effects of a kernel API change
References: <292693080701172015n736a269fl6945ba4fe19d8174@mail.gmail.com>
	<20070118051026.GA29695@Ahmed>
	<b115cb5f0701172135k411dca56u92101a929799548a@mail.gmail.com>
Date: Thu, 18 Jan 2007 00:47:42 -0700
In-Reply-To: <b115cb5f0701172135k411dca56u92101a929799548a@mail.gmail.com>
	(Rajat Jain's message of "Thu, 18 Jan 2007 11:05:53 +0530")
Message-ID: <m1mz4g7p41.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rajat Jain" <rajat.noida.india@gmail.com> writes:

>> >
>> > Is there any way volunteers like me can help in this exercise?
>>
>> See the /APIchanges in the Kernel Janitors TODO list
>> http://kernelnewbies.org/KernelJanitors/Todo
>>
>
> Hi,
>
> This is regarding the link posted above.
>
> 1) How do I make sure if some one is NOT working on any of the
> mentioned bullet points? Who coordinates? On what mailing list?

Depends on the issue.  Release early and release often and there
won't be much duplicate work :)

> 2) Do any patches for the above Todo list have the chances of getting
> merged into the mainstream kernel? Who approves? I suppose the
> respective maintainer of the driver / subsystem getting affected?

Generally. Occasionally for small things other paths are available.

Eric
