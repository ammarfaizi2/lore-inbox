Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSJIViV>; Wed, 9 Oct 2002 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSJIViV>; Wed, 9 Oct 2002 17:38:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46259 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262033AbSJIViU>;
	Wed, 9 Oct 2002 17:38:20 -0400
Date: Wed, 09 Oct 2002 14:36:53 -0700 (PDT)
Message-Id: <20021009.143653.104749507.davem@redhat.com>
To: fuji@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: bondind 6 NICs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021009205843.GA20614@chiara.elte.hu>
References: <20021009204920.6F0B74483@sitemail.everyone.net>
	<20021009205843.GA20614@chiara.elte.hu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: KELEMEN Peter <fuji@elte.hu>
   Date: Wed, 9 Oct 2002 22:58:43 +0200
   
   That's actually much further than I managed.  2.4.19 completely
   freezes when configuring the bonding interface (bond0), only power
   cycle helps.  I'm trying to bond two 3Com Vortex cards together.
   
 Known bug, fix in 2.4.20-preX
