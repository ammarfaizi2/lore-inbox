Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJ1RB6>; Mon, 28 Oct 2002 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJ1RB5>; Mon, 28 Oct 2002 12:01:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63659 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261312AbSJ1RB4>;
	Mon, 28 Oct 2002 12:01:56 -0500
Date: Mon, 28 Oct 2002 08:58:51 -0800 (PST)
Message-Id: <20021028.085851.94768450.davem@redhat.com>
To: willy@debian.org
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, hugh@veritas.com,
       akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021028170633.R27461@parcelfarce.linux.theplanet.co.uk>
References: <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
	<20021028.085536.32752918.davem@redhat.com>
	<20021028170633.R27461@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Mon, 28 Oct 2002 17:06:33 +0000

   On Mon, Oct 28, 2002 at 08:55:36AM -0800, David S. Miller wrote:
   > Need to go into the revision history, discover who added these
   > calls, and ask them why they were added.
   
   They're in 2.2.20, if it helps...

That's not so useful, it's the who and why that matters. :-)
