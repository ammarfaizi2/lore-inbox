Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWANRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWANRLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWANRLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:11:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3994 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750702AbWANRLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:11:44 -0500
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601141203.21446.dtor_core@ameritech.net>
References: <20060114160253.GA1073@elte.hu>
	 <200601141121.43749.dtor_core@ameritech.net>
	 <1137257347.3014.38.camel@laptopd505.fenrus.org>
	 <200601141203.21446.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 18:11:39 +0100
Message-Id: <1137258700.3014.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 12:03 -0500, Dmitry Torokhov wrote:
> > > All input related mutex conversions look fine so far. What are the plans
> > > on merging it? Do you want to trickle them in through subsystems or just
> > > submit as one batch? IOW do you want me to apply these patches?
> > 
> > please apply them to your queue; that's the best and easiest for
> > everyone.
> >
> 
> OK, will do. But it is 2.6.17 material, isn't it? 

that is entirely your call. Some maintainers have sent it for 2.6.16
already (arguably ones where the diff was not too big)...


