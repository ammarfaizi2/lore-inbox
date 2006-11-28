Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757214AbWK1WwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbWK1WwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbWK1WwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:52:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:35251 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757214AbWK1WwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:52:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lje6TtPUUmhjnFYvBx2oIJ3VhxOWGwmZrOhp2DWZkTWAPKj2QuFJFPk6gXR7UGtdxsUQV1QSGmEn/V6mwrgsdIrZvs+HoWjUHK3k6tNXp2dUtw/4XAlsG7+U6Ozb8X8rbWuE2d6t9r1TVY2N9xqKUjDkmeM2LICOLHrdXX5ZBF8=
Message-ID: <5bdc1c8b0611281452w49b6a3c3rb35ab055fc0b2660@mail.gmail.com>
Date: Tue, 28 Nov 2006 14:52:14 -0800
From: "Mark Knecht" <markknecht@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt5
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061128201549.GC26934@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061120220230.GA30835@elte.hu>
	 <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
	 <1164735207.1701.19.camel@mindpipe> <20061128201549.GC26934@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding it off list.

Thanks Ingo. I'm very interested if it works for you to do this.

Cheers,
Mark

On 11/28/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Lee Revell <rlrevell@joe-job.com> wrote:
>
> > >    I know there were some comments awhile back about being required
> > > to switch to PAM. Has that occurred?
> > >
> > >    If not then there is a regression issue for realtime-lsm.
> >
> > As Realtime LSM is an out of tree module and there's no stable kernel
> > module API it's impossible to prevent regressions.
> >
> > That being said, the realtime LSM patch is so simple that it should
> > work - how exactly does it fail?
>
> i can include it in -rt if it's simple enough - if someone's interested
> then please send me a patch.
>
>         Ingo
>
