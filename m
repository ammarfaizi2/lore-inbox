Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbUJYUa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUJYUa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUJYUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:30:10 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:54003 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261310AbUJYUZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:25:36 -0400
Subject: Re: linux 2.6.9 on alpha noritake
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041024195923.A794@den.park.msu.ru>
References: <1098476483.11296.37.camel@pro30.local.promotion-ie.de>
	 <1098520279.14984.12.camel@pro30.local.promotion-ie.de>
	 <20041023175811.GA23184@twiddle.net> <20041024144329.A623@den.park.msu.ru>
	 <1098632003.8479.4.camel@pro30.local.promotion-ie.de>
	 <20041024195923.A794@den.park.msu.ru>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1098736003.28742.4.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 22:26:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 24.10.2004 schrieb Ivan Kokshaysky um 17:59:
> On Sun, Oct 24, 2004 at 05:33:23PM +0200, alex@local.promotion-ie.de wrote:
> > but as usually one thing fixed next broken....
> > now the sym53c8xx won't scan the SCSI bus.
just tested 1.6.10-rc1-bk3 with your patches ...
... boots ... sym53c8xx works ... __ioremap is defined ... but

the sysrq help messages keeps getting printed to the console over and
over again ... but I haven't pressed any key at all

any ideas???

thanks for your quick help

Alex

