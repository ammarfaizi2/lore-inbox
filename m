Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUIMWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUIMWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIMWw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:52:28 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:33703
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269034AbUIMWuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:50:22 -0400
Date: Mon, 13 Sep 2004 15:48:28 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Anton Blanchard <anton@samba.org>
Cc: moilanen@austin.ibm.com, roland@topspin.com, Michael.Waychison@Sun.COM,
       plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040913154828.35d60ac1.davem@davemloft.net>
In-Reply-To: <20040908130728.GA2282@krispykreme>
References: <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
	<52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
	<52ekljq6l2.fsf@topspin.com>
	<20040907133332.4ceb3b5a@localhost>
	<52isapkg9z.fsf@topspin.com>
	<20040908073412.3b7c9388@localhost>
	<20040908130728.GA2282@krispykreme>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004 23:07:28 +1000
Anton Blanchard <anton@samba.org> wrote:

>  
> > I've had mixed results.  On some of my blades it never works.  On others
> > it will come up every third attempt or so.
> 
> 2.6 BK as of 2 days ago wasnt working on my JS20 either. Ive been
> meaning to look closer but havent had a chance yet.

Are you going to work on this soon Anton?  I will cook up some
debugging patches, this bug sucks and I want to fix it soon.
