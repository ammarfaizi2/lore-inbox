Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVFGXZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVFGXZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVFGXZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:25:10 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18838
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262034AbVFGXZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:25:05 -0400
Subject: Re: [Trivial PATCH] new timeofday: move time sources into arch
	subdirectories
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1118185935.5191.6.camel@leatherman>
References: <1118181331.20785.547.camel@tglx.tec.linutronix.de>
	 <1118185935.5191.6.camel@leatherman>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 08 Jun 2005 01:25:51 +0200
Message-Id: <1118186751.20785.549.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 16:12 -0700, john stultz wrote:
> Hey! Thanks for the feedback! I'm trying to encourage architectures to
> share timesource drivers, so for now I'm not so worried if we end up
> with something that looks like drivers/net/. 

It will :)

> So unless you strenuously object, I say lets put it off until the need
> becomes a bit more apparent. Although its likely I'll agree with you
> once I've started working on converting ARM. :)

I looked at ARM particular and it has about 20+ implementations.

tglx


