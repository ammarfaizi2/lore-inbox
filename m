Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264102AbTCXEvr>; Sun, 23 Mar 2003 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264103AbTCXEvr>; Sun, 23 Mar 2003 23:51:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33993 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264102AbTCXEvr>;
	Sun, 23 Mar 2003 23:51:47 -0500
Date: Sun, 23 Mar 2003 21:00:34 -0800 (PST)
Message-Id: <20030323.210034.35199604.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030324153239.520f43c7.sfr@canb.auug.org.au>
References: <20030323.010026.18275919.davem@redhat.com>
	<20030324113626.3267fb08.sfr@canb.auug.org.au>
	<20030324153239.520f43c7.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Mon, 24 Mar 2003 15:32:39 +1100

   Here is the rediffed patch but you still need linus to apply the previous
   patch which defines compat_uptr_t ...

Thanks Stephen, I'll apply this once Linus takes your other
patch.

Thanks again.
