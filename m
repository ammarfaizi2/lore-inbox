Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137179AbREKRLc>; Fri, 11 May 2001 13:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137180AbREKRLW>; Fri, 11 May 2001 13:11:22 -0400
Received: from zmailer.org ([194.252.70.162]:28423 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S137179AbREKRLF>;
	Fri, 11 May 2001 13:11:05 -0400
Date: Fri, 11 May 2001 20:10:56 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Byron Albert <balbert@internet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test -please disregard
Message-ID: <20010511201056.J5947@mea-ext.zmailer.org>
In-Reply-To: <3AFBFB7B.D8A91364@internet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AFBFB7B.D8A91364@internet.com>; from balbert@internet.com on Fri, May 11, 2001 at 10:47:23AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 10:47:23AM -0400, Byron Albert wrote:
> Date:	Fri, 11 May 2001 10:47:23 -0400
> From:	Byron Albert <balbert@internet.com>
> To:	linux-kernel@vger.kernel.org
> Subject: test -please disregard
> 
> I have not recived mail from the list for more than a day just a test
> .....

  I find the logic of these "test - please disregard" emails weird..
  You definitely want list-owners attention, perhaps Postmasters...

  If somebody doesn't receive email from vger's  linux-kernel  for
  few HOURS, there is either something wrong in the systems(*), or
  the recipient has been removed for some reason.

  *) "systems" include vger itself (it has died this week alone 4-5 times),
     network connectivity from vger to you, and your local email systems.

  If   http://vger.kernel.org/   answers, vger *is* operational, and
  its email system should be operational too -- or then myself or DaveM
  are just doing something to it.


  The case at hand:

  A burst of rejections from your service ISP:

May  7 18:42:54 vger smtp[2973]: S136669AbREGV1F:
	to=<balbert@internet.com>, delay=01:15:49, xdelay=00:10:03, mailer=smtp,
	relay=natasha.iworld.com ([63.95.15.6|25|199.183.24.194|4643]),
	stat=error2 550 5.1.1 <balbert@internet.com>... User unknown
May  7 18:45:22 vger smtp[2973]: S136668AbREGU70:
	to=<balbert@internet.com>, delay=01:45:56, xdelay=00:02:28, mailer=smtp,
	relay=natasha.iworld.com ([63.95.15.6|25|199.183.24.194|4643]),
	stat=deferred remote hung up on us while 1 responses missing

  I could bet that the beast did run out of some critical resources, and
  it shows the result like this.   It *really* sucks...

  Of course the  linux-kernel-owner  receives *only* the "stat=error*" cases;
  you could say "distilled bad news" -- even if only one or two failure 
  cases out hundreds of successfull, we may still think that the address
  just became nonexistent...


/Matti Aarnio  -- vger's co-postmaster ; reach us at:
                            postmaster@vger.kernel.org
