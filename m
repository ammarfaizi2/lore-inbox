Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWANROu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWANROu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWANROu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:14:50 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:16541 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750701AbWANROt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:14:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
Date: Sat, 14 Jan 2006 12:14:46 -0500
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060114160253.GA1073@elte.hu> <200601141203.21446.dtor_core@ameritech.net> <1137258700.3014.42.camel@laptopd505.fenrus.org>
In-Reply-To: <1137258700.3014.42.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141214.47220.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 12:11, Arjan van de Ven wrote:
> On Sat, 2006-01-14 at 12:03 -0500, Dmitry Torokhov wrote:
> > > > All input related mutex conversions look fine so far. What are the plans
> > > > on merging it? Do you want to trickle them in through subsystems or just
> > > > submit as one batch? IOW do you want me to apply these patches?
> > > 
> > > please apply them to your queue; that's the best and easiest for
> > > everyone.
> > >
> > 
> > OK, will do. But it is 2.6.17 material, isn't it? 
> 
> that is entirely your call. Some maintainers have sent it for 2.6.16
> already (arguably ones where the diff was not too big)...
>

I'd really like it to see one -mm release... 

-- 
Dmitry
