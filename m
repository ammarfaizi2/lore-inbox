Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSJMG6y>; Sun, 13 Oct 2002 02:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJMG6y>; Sun, 13 Oct 2002 02:58:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261451AbSJMG6x>;
	Sun, 13 Oct 2002 02:58:53 -0400
Date: Sat, 12 Oct 2002 23:57:56 -0700 (PDT)
Message-Id: <20021012.235756.130619930.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: convert /proc/net/arp to seq_file
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021013065656.GC7898@conectiva.com.br>
References: <20021013065656.GC7898@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 13 Oct 2002 04:56:56 -0200

   	Please consider pulling from:
   
   master.kernel.org:/home/acme/BK/ip-2.5
   
Pulled, thanks.
   
   PS.: Any feedback from the pppoe maintainer about seq_file patch?

None that I've seen :(

We should just put the changes in, if the maintainer really
cares he can revert them later after making his case.

Can you repost the changes in question?
