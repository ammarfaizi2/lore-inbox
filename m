Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTJ3RuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTJ3RuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:50:23 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:21411 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262719AbTJ3RuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:50:20 -0500
Subject: Re: Transmit timeout with 3c395, 2.4.19, 2.4.22
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031027111827.07b04891.akpm@osdl.org>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
	 <20031027111827.07b04891.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1067536222.1197.8.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Oct 2003 18:50:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 27.10.2003 kl. 20.18 skrev Andrew Morton:
> Norbert Preining <preining@logic.at> wrote:
> >
> > Hi Andrew, hi list!
> > 
> > Suddenly, after 160 days of running, our bridged firewall started to
> > spit out this:
> > NETDEV WATCHDOG: eth1: transmit timed out

My gateway started to give me this errors on eth0 some days ago. Eth0 is
the internal network-card, which is connected to just one pc through a
crossed tp-cable. When I run a certain app on my pc (xMule), the gateway
alway starts spitting those messages.

Could have been hardware, but only happens when xmule is active on my
computer. Wasn't like this earlier.

