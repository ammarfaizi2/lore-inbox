Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289027AbSAQATd>; Wed, 16 Jan 2002 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288599AbSAQATX>; Wed, 16 Jan 2002 19:19:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288012AbSAQATE>;
	Wed, 16 Jan 2002 19:19:04 -0500
Date: Wed, 16 Jan 2002 16:17:59 -0800 (PST)
Message-Id: <20020116.161759.68040363.davem@redhat.com>
To: wilson@whack.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hires timestamps for netif_rx()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.40.0201161514030.5375-100000@apogee.whack.org>
In-Reply-To: <20020116180042.A21447@willow.seitz.com>
	<Pine.GSO.4.40.0201161514030.5375-100000@apogee.whack.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Wilson Yeung <wilson@whack.org>
   Date: Wed, 16 Jan 2002 15:33:04 -0800 (PST)

   I'd love to have a run-time tuneable kernel parameter that lets me use
   do_gettimeofday() instead of get_fast_time for received packet
   timestamping.  Does this seem reasonable?
   
Can you demonstrate a difference in accurace between these two
routines on any architecture :-)
