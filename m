Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDELW5>; Thu, 5 Apr 2001 07:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDELWs>; Thu, 5 Apr 2001 07:22:48 -0400
Received: from [202.54.26.202] ([202.54.26.202]:46494 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132606AbRDELWl>;
	Thu, 5 Apr 2001 07:22:41 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Zdenek Kabelac <kabi@i.am>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Message-ID: <65256A25.003D0DBC.00@sandesh.hss.hns.com>
Date: Thu, 5 Apr 2001 16:44:01 +0530
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This concept I think is used in Solaris .. as they have dynamic loadable
schedulers..




Zdenek Kabelac <kabi@i.am> on 04/05/2001 05:43:15 PM

To:   Andrea Arcangeli <andrea@suse.de>
cc:    (bcc: Amol Lad/HSS)

Subject:  Re: [Lse-tech] Re: a quest for a better scheduler





Hello

Just dump idea - why not make scheduler switchable with modules - so
users
could select any scheduler they want ?

This should not be that hard and would make it easy to replace scheduler
at runtime so everyone could easily try what's the best for him/her.

kabi@i.am

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




