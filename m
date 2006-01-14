Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWANQtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWANQtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWANQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:49:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751204AbWANQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:49:13 -0500
Subject: Re: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601141121.43749.dtor_core@ameritech.net>
References: <20060114160253.GA1073@elte.hu>
	 <200601141121.43749.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 17:49:07 +0100
Message-Id: <1137257347.3014.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 11:21 -0500, Dmitry Torokhov wrote:
> On Saturday 14 January 2006 11:02, Ingo Molnar wrote:
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > semaphore to mutex conversion.
> > 
> > the conversion was generated via scripts, and the result was validated
> > automatically via a script as well.
> >
> 
> All input related mutex conversions look fine so far. What are the plans
> on merging it? Do you want to trickle them in through subsystems or just
> submit as one batch? IOW do you want me to apply these patches?

please apply them to your queue; that's the best and easiest for
everyone.


