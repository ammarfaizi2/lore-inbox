Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbULXSwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbULXSwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbULXSwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:52:16 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28558 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261436AbULXSwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:52:15 -0500
Subject: Re: VM fixes [1/4]
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
In-Reply-To: <20041224184844.GK13747@dualathlon.random>
References: <20041224173519.GB13747@dualathlon.random>
	 <20041224100016.530a004c.davem@davemloft.net>
	 <20041224182031.GG13747@dualathlon.random>
	 <1103913664.3921.2.camel@krustophenia.net>
	 <20041224184844.GK13747@dualathlon.random>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 13:52:14 -0500
Message-Id: <1103914334.3921.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-24 at 19:48 +0100, Andrea Arcangeli wrote:
> But what's the point of
> enabling preempt in such an ancient hardare?
> 

None really, but it seems like many people enable preempt who don't need
it.

Lee

