Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274339AbRISXvT>; Wed, 19 Sep 2001 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274323AbRISXvQ>; Wed, 19 Sep 2001 19:51:16 -0400
Received: from mx2.utanet.at ([195.70.253.46]:18863 "EHLO smtp1.utaiop.at")
	by vger.kernel.org with ESMTP id <S274281AbRISXuD>;
	Wed, 19 Sep 2001 19:50:03 -0400
Message-ID: <3BA94B2E.99FABD43@grips.com>
Date: Thu, 20 Sep 2001 03:49:34 +0200
From: Gerold Jury <geroldj@grips.com>
Organization: Grips
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre10-xfs i686)
X-Accept-Language: de-AT, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Feedback on preemptible kernel patch xfs
In-Reply-To: <1000581501.32705.46.camel@phantasy> 
		<3BA72A80.6020706@grips.com> <1000853560.19365.13.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

First the good news.
Even my most ugly ideas where not able to crash your preemtible 2.4.10-pre10-xfs

But, to be sure i repeated everything, neither latencytest-0.42 nor my own tests could
find a difference with or without the preemptible patch.
I do not know if i can expect a lower latency at this stage of development.

A maximum of 15 msec latency with all the stress, i managed to put on the machine
is not that bad anyway.

The CPU is a 1.1GHz Athlon. I forgot to mention this.

I will continue to test the preempt patches.

Do you want me to test anything special ?

Best Regards
Gerold
