Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTEGMPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTEGMPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:15:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1666 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263056AbTEGMPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:15:37 -0400
Date: Wed, 07 May 2003 04:20:35 -0700 (PDT)
Message-Id: <20030507.042035.13750321.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at net/core/skbuff.c:1028!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507121412.GI823@suse.de>
References: <20030507121412.GI823@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 7 May 2003 14:14:12 +0200

   Booting 2.5-BK on my little router BUG's out before the login is
   reached. 100% reproduceable. Let me know if you want more detail.

I forwarded this to Rusty, I think netfilter changes he made
recently have caused this.
