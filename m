Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVAXK3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVAXK3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVAXK3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:29:44 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:54156 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261479AbVAXK3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:29:43 -0500
Message-ID: <41F4CE0E.8030508@yahoo.com.au>
Date: Mon, 24 Jan 2005 21:29:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <4d8e3fd3050124015528615310@mail.gmail.com>
In-Reply-To: <4d8e3fd3050124015528615310@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> On Mon, 24 Jan 2005 09:59:02 +0100, Ingo Molnar <mingo@elte.hu> wrote:
> [...]
> 
>>- CKRM is another possibility, and has nonzero costs as well, but solves
>> a wider range of problems.
> 
> 
> BTW, do you know what's the status of CKRM ?
> If I'm not wrong it is already widely used, is there any plan to push
> it to mainstream ?
> 

The CKRM CPU scheduler is under development and it is usable, but it
seems like it has quite a long way to go before it could be considered
for merging.

