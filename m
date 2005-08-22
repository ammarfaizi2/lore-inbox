Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVHVWLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVHVWLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVHVWLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751258AbVHVWLl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SV0onHgPQ+/BEjFFcUYHauuuR/nct9QVDWV6slyV0KU5C2A4JzDTM7lYOwvRFROfIDbKUpI83/RzZ+0CGBi0Jki2ZeQHygjpYJSQPEqi0gzGTnIv8UaPYMEheDxVerA/ZuMg4XGWLRUaCgaKYio9ojmWR93YxaEuTHpMtXvKF4Q=
Message-ID: <6bffcb0e05082204394b4a8d04@mail.gmail.com>
Date: Mon, 22 Aug 2005 13:39:51 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4309125B.4020707@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081614498879a72@mail.gmail.com>
	 <6bffcb0e050820183713edf253@mail.gmail.com>
	 <4309125B.4020707@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/22/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
> Michal Piotrowski wrote:
> > [1.] One line summary of the problem:
> > oops when shuting down system
> >
> > [2.] Full description of the problem/report:
> > After kernbenching nicksched (heav load make -j128) I just record
> > results on cd and shutdown system.
> 
> Does the same problem occur with any of the other schedulers or is it
> specific to nicksched?
> 
> Peter
> --
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce
> 

I don't know, I can't reproduce it. Maybe It's not plugsched problem.

Regards,
Michal Piotrowski
