Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSETEoZ>; Mon, 20 May 2002 00:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSETEoY>; Mon, 20 May 2002 00:44:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315760AbSETEoY>;
	Mon, 20 May 2002 00:44:24 -0400
Date: Sun, 19 May 2002 21:30:39 -0700 (PDT)
Message-Id: <20020519.213039.92674009.davem@redhat.com>
To: torvalds@transmeta.com
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205191742130.10180-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 19 May 2002 17:47:01 -0700 (PDT)
   
   Finally, I haven't really heard anything back from the "strange" VM
   architectures (ie sparc v8 and PPC) other than Davem's buy-in that the
   basic approach should work ok for them.

I haven't had time this weekend to even look at sparc64.
Sparc v8 is doesn't even work with the 2.5.x tree before
your VM changes, it will be months before sparc32 is in
any kind of working shape in the 2.5.x tree, if at all.

So expect something wrt. sparc64 soon, and don't hold your breath
on sparc32.
