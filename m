Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUIRJ2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUIRJ2T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 05:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUIRJ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 05:28:19 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:469 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266477AbUIRJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 05:28:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc1-mm5: double fault on resume on Athlon64 w/ NForce 3
Date: Sat, 18 Sep 2004 11:30:08 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <200409132357.13582.rjw@sisk.pl> <20040916204908.GA8772@elf.ucw.cz> <200409180953.20690.rjw@sisk.pl>
In-Reply-To: <200409180953.20690.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181130.08832.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 of September 2004 09:53, Rafael J. Wysocki wrote:
> On Thursday 16 of September 2004 22:49, Pavel Machek wrote:
> > Hi!
> > 
> > > JFYI, I get a double fault on resume on an Athlon64-based box:
> > 
> > Try the patch I sent to lkml few minutes ago.
> 
> Unfortunately, on 2.6.9-rc2-mm1 I'm still getting things like this:
[- snip -]

I should have said it's with your patch applied.  Sorry,

RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
