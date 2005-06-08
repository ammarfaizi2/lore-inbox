Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFHQ0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFHQ0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFHQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:23:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30108
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261347AbVFHQWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:22:53 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, kus Kusche Klaus <kus@keba.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050608155049.GA7160@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323235@MAILIT.keba.co.at>
	 <Pine.LNX.4.10.10506080847590.28001-100000@godzilla.mvista.com>
	 <20050608155049.GA7160@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 08 Jun 2005 18:23:42 +0200
Message-Id: <1118247822.20785.634.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 17:50 +0200, Ingo Molnar wrote:
> > So it's pretty much on hold until someone bring ARM into the generic 
> > IRQ world.
> 
> Thomas and me already did that - i think Thomas could send a patch for 
> review?

I have to bring it forward to -rc6. 

tglx


