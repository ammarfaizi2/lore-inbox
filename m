Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261673AbTCKXbw>; Tue, 11 Mar 2003 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbTCKXbw>; Tue, 11 Mar 2003 18:31:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20713 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261673AbTCKXbt>;
	Tue, 11 Mar 2003 18:31:49 -0500
Date: Tue, 11 Mar 2003 15:42:14 -0800 (PST)
Message-Id: <20030311.154214.24008032.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 3/9 sparc64 part
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030311115000.41734959.sfr@canb.auug.org.au>
References: <20030311114113.44abed66.sfr@canb.auug.org.au>
	<20030311115000.41734959.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Tue, 11 Mar 2003 11:50:00 +1100

   Here is the sparc64 part of the patch.  Please apply after Linus applies
   the gerneic part.

Thanks Stephen.

You know, you're doing such a good job with this, that you can
just stick the sparc64 parts into your main patch if you want.
You don't need to push it through me each time if you don't want.
