Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSFRCXB>; Mon, 17 Jun 2002 22:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSFRCXA>; Mon, 17 Jun 2002 22:23:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20893 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317280AbSFRCXA>;
	Mon, 17 Jun 2002 22:23:00 -0400
Date: Mon, 17 Jun 2002 19:17:26 -0700 (PDT)
Message-Id: <20020617.191726.55300824.davem@redhat.com>
To: acme@conectiva.com.br
Cc: critson@perlfu.co.uk, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020618005735.GB1146@conectiva.com.br>
References: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk>
	<20020617.143319.54623892.davem@redhat.com>
	<20020618005735.GB1146@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Mon, 17 Jun 2002 21:57:35 -0300

   --- orig/net/ipv6/tcp_ipv6.c	Sat May 25 23:13:56 2002
   +++ linux/net/ipv6/tcp_ipv6.c	Fri Jun 14 23:23:07 2002

I've installed this change into my tree in the meantime.
If we find a better fix, we can just revert this.

Thanks.
