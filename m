Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbTCRHYD>; Tue, 18 Mar 2003 02:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTCRHYD>; Tue, 18 Mar 2003 02:24:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262183AbTCRHYD>;
	Tue, 18 Mar 2003 02:24:03 -0500
Date: Mon, 17 Mar 2003 23:33:37 -0800 (PST)
Message-Id: <20030317.233337.76754195.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030318182935.0aa53710.sfr@canb.auug.org.au>
References: <20030318181824.6f593d2c.sfr@canb.auug.org.au>
	<20030317.232218.91332148.davem@redhat.com>
	<20030318182935.0aa53710.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Tue, 18 Mar 2003 18:29:35 +1100

   On Mon, 17 Mar 2003 23:22:18 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
   > Why not include/net/compat.h?
   
   Because compat_socket.h is already there ... I didn't create it.

I'm saying to move this stuff to include/net/compat.h instead
of creating this new meaningless net/compat_socket.h file.
