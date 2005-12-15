Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVLOXO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVLOXO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVLOXO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:14:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48002 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751099AbVLOXO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:14:56 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
References: <20051211180536.GM23349@stusta.de>
	 <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 18:13:25 -0500
Message-Id: <1134688406.12086.170.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 23:57 +0100, Jan Engelhardt wrote:
> >It seems most problems with 4k stacks are already resolved at least
> >in -mm.
> >
> >I'd like to see this patch to always use 4k stacks in -mm now for 
> >finding any remaining problems before submitting this patch for Linus' 
> >tree.
> 
> By chance, I read that windows modules used in ndiswrapper
> may require >4k-stacks. Will this become a problem?

Please refer to the last 5 flamewars on this issue rather than starting
another one.

Lee

