Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHQCgy>; Thu, 16 Aug 2001 22:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHQCgn>; Thu, 16 Aug 2001 22:36:43 -0400
Received: from toscano.org ([64.50.191.142]:60670 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S269463AbRHQCgi>;
	Thu, 16 Aug 2001 22:36:38 -0400
Date: Thu, 16 Aug 2001 22:36:50 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver
Message-ID: <20010816223650.A17597@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108170013.f7H0DoO21290@ccsi.com> <200108170104.f7H14CI83159@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108170104.f7H14CI83159@aslan.scsiguy.com>
User-Agent: Mutt/1.3.20i
X-Unexpected: The Spanish Inquisition
X-Uptime: 10:36pm  up 5 days, 15:18,  5 users,  load average: 1.31, 1.26, 1.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Aug 2001, Justin T. Gibbs wrote:

> If you manually go into drivers/scsi/aic7xxx/aicasm and do a make clean, the
> error should go away.

I concur.  I did exactly this and everything (well, WRT the aic7xxx
driver) was fine.

pete
