Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289644AbSAOUJK>; Tue, 15 Jan 2002 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289659AbSAOUJA>; Tue, 15 Jan 2002 15:09:00 -0500
Received: from colorfullife.com ([216.156.138.34]:7687 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289639AbSAOUIz>;
	Tue, 15 Jan 2002 15:08:55 -0500
Message-ID: <001801c19e00$71c355a0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Benjamin LaHaise" <bcrl@redhat.com>,
        "Hubertus Franke" <frankeh@watson.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
In-Reply-To: <002701c19638$400f15f0$010411ac@local> <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com> <20020115145747.F6853@redhat.com>
Subject: Re: [Lse-tech] zerocopy pipe, new version
Date: Tue, 15 Jan 2002 21:08:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Benjamin LaHaise" <bcrl@redhat.com>
> 
> Any conclusions are incomplete without mentioning the serious (30%+) 
> degredation on UP systems under a good chunk of the benchmarks.  Such 
> aspects of the patch make it unsuitable as is for both the mainstream 
> and vendor kernels.
>
My patch is definitively WIP - right now I again broke the -ENOMEM and
-EFAULT handling.

--
    Manfred

