Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUFQAoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUFQAoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 20:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266329AbUFQAoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 20:44:10 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:32492 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264774AbUFQAoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 20:44:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
Date: Thu, 17 Jun 2004 10:43:50 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <1087333441.40cf6441277b5@vds.kolivas.org> <40D047C4.30209@kolivas.org> <40D0BEF6.9030901@gmx.de>
In-Reply-To: <40D0BEF6.9030901@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406171043.50457.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 07:43, Prakash K. Cheemplavam wrote:
> Con Kolivas wrote:
> > Prakash K. Cheemplavam wrote:
> >> Con Kolivas wrote:
> >> >> Prakash K. Cheemplavam wrote:
> >>>>>> Con Kolivas wrote:
> >>>>>>>> Here is an updated version of the staircase scheduler. I've been
> >>>>>
> >>>>> trying to hold
> >>>>> off for 2.6.7 final but this has not been announced yet. Here is a
> >>>>> brief update
> >>>>> summary.
> >>>>
> >>>> Hi, does this resolve the issue with ut2004? (Or is another setting
> >>>> for it needed?) I haven't tried myself, but others reported that
> >>>> setting interactive to 0 didn't help, nor giving ut2004 more
> >>>> priority via (re)nice.
> >>>
> >>> Good question. I don't own UT2004 so I was hoping a tester might
> >>> enlighten me.
>
> SO, I tried out vanilla + ck1 and guess what: ut2004 runs without probs,
> I haven't changed anything. COuld it be mm related? I think I will try
> your latest patch with mm again and see how it goes.

Great! Any sort of acpi or sound driver update could be responsible, but I'm 
glad to hear it's working for you.

Thanks for feedback.
COn
