Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284967AbRLRURX>; Tue, 18 Dec 2001 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285006AbRLRURO>; Tue, 18 Dec 2001 15:17:14 -0500
Received: from mout0.freenet.de ([194.97.50.131]:31879 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S284958AbRLRUQz>;
	Tue, 18 Dec 2001 15:16:55 -0500
Message-ID: <3C1FA3E4.6000903@athlon.maya.org>
Date: Tue, 18 Dec 2001 21:15:32 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
In-Reply-To: <3C1F8825.2080802@athlon.maya.org> <20011218124132.B32316@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ken,

Ken Brownfield wrote:

 > Are you seeing this in earlier kernels?  What about with "noapic"?


Yes, in all 2.4.x - vanilla kernels. But not in the ac-patches!

I tested it wit or without apic - the behaviour didn't change.


Regards,
Andreas


