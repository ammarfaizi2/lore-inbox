Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTAJEN6>; Thu, 9 Jan 2003 23:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTAJEN6>; Thu, 9 Jan 2003 23:13:58 -0500
Received: from holomorphy.com ([66.224.33.161]:54422 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261451AbTAJEN5>;
	Thu, 9 Jan 2003 23:13:57 -0500
Date: Thu, 9 Jan 2003 20:19:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Tinsley <btinsley@emageon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110041918.GK23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Tinsley <btinsley@emageon.com>, linux-kernel@vger.kernel.org
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com> <20030110035412.GJ23814@holomorphy.com> <3E1E4757.3060206@emageon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E4757.3060206@emageon.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I don't know what to tell you here. I'm lucky that this is my day job
>> and that I can contribute so much. However, there are plenty who
>> contribute major changes (many even more important than my own) without
>> any such sponsorship. Perhaps emulating them would satisfy your wish.

On Thu, Jan 09, 2003 at 10:08:55PM -0600, Brian Tinsley wrote:
> It would!
> I cannot say thanks enough for the efforts of you and everyone else out 
> there. Frankly, I would not have my day job and would not have been able 
> to make Emageon what it is today were it not for you all!
> Oh, please excuse the stupid humor tonight. I'm in a giddy mood for some 
> reason. Must be the excitement from the prospect of getting resolution 
> to this problem!

We're straying from the subject here. Please describe your machine,
in terms of how many cpus it has and how much highmem it has, and
your workload, so I can better determine the issue. Perhaps we can
cooperatively devise something that works well for you.

Or perhaps the kernel version is not up-to-date. Please also provide
the precise kernel version (and included patches). And workload too.


Thanks,
Bill
