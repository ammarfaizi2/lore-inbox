Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbSJGIJu>; Mon, 7 Oct 2002 04:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262925AbSJGIJu>; Mon, 7 Oct 2002 04:09:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34454 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262922AbSJGIJt>;
	Mon, 7 Oct 2002 04:09:49 -0400
Date: Mon, 07 Oct 2002 01:08:43 -0700 (PDT)
Message-Id: <20021007.010843.130618724.davem@redhat.com>
To: kai-germaschewski@uiowa.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild news
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210052048130.13557-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0210052048130.13557-100000@chaos.physics.uiowa.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
   Date: Sat, 5 Oct 2002 21:10:06 -0500 (CDT)

   o The final link of vmlinux is now always done as a two step process:

This doesn't seem to be happening "always" now in current
2.5.x, I did not see a .tmp_vmlinux get generated.

It seems the whole mechanism to do kallsyms got redone since
you sent this email.
