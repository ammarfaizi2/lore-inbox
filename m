Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270912AbRHNWs2>; Tue, 14 Aug 2001 18:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270907AbRHNWsR>; Tue, 14 Aug 2001 18:48:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51844 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270916AbRHNWsE>;
	Tue, 14 Aug 2001 18:48:04 -0400
Date: Tue, 14 Aug 2001 15:46:09 -0700 (PDT)
Message-Id: <20010814.154609.99205977.davem@redhat.com>
To: goemon@anime.net
Cc: chrisc@shad0w.org.uk, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CDP handler for linux
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0108141429040.31529-100000@anime.net>
In-Reply-To: <Pine.LNX.4.33.0108142137300.3810-100000@monolith.shad0w.org.uk>
	<Pine.LNX.4.30.0108141429040.31529-100000@anime.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Hollis <goemon@anime.net>
   Date: Tue, 14 Aug 2001 14:32:40 -0700 (PDT)

   On Tue, 14 Aug 2001, Chris Crowther wrote:
   > either - it just sits there, collecting and sending information.  The only
   > thing you would really need in userspace, would be tools to read
   > information from the cdp handler if you wanted to do more than just look
   > at the neighbor summary.  I can't see any real advantages of running it as
   > a daemon as opposed to a kernel component.
   
   Except that as userspace daemon if cdpd goes splat the kernel generally
   doesnt go splat either.
   
I really think this should be in userspace too.

Later,
David S. Miller
davem@redhat.com
