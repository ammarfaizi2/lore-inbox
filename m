Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSJTG54>; Sun, 20 Oct 2002 02:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbSJTG54>; Sun, 20 Oct 2002 02:57:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15833 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262602AbSJTG5z>;
	Sun, 20 Oct 2002 02:57:55 -0400
Date: Sat, 19 Oct 2002 23:56:05 -0700 (PDT)
Message-Id: <20021019.235605.15274262.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record per fib_seq_sholl call
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021020061031.GA15857@conectiva.com.br>
References: <20021020061031.GA15857@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 20 Oct 2002 03:10:31 -0300

   	Here it is, fib code fixed and moved back to fib
   implementation, please consider pulling from:
   
   master.kernel.org:/home/acme/BK/net-2.5

Looks great, pulled.

Thanks a lot for this work.
