Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHXJau>; Sat, 24 Aug 2002 05:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSHXJau>; Sat, 24 Aug 2002 05:30:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40098 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315445AbSHXJau>;
	Sat, 24 Aug 2002 05:30:50 -0400
Date: Sat, 24 Aug 2002 02:19:37 -0700 (PDT)
Message-Id: <20020824.021937.60281893.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org
Subject: Re: [patch] 2.4.20-pre4 sparc32 fixup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020824093304.GU14278@louise.pinerecords.com>
References: <20020824093304.GU14278@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sat, 24 Aug 2002 11:33:04 +0200

   The patch inlined below gets 2.4.20-pre4 to compile (and boot) on my
   testmachine again. Trivial stuff mostly, dunno about the page_to_phys
   macro, though -- DaveM, could you have a look at it?
   
I told you I applied this to my tree already.  Why are you resending
it?

I didn't get to merge my sparc stuff to Marcelo until late this
afternoon (PST time).
