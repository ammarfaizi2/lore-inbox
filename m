Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265726AbSJTAlI>; Sat, 19 Oct 2002 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSJTAlI>; Sat, 19 Oct 2002 20:41:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64214 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265726AbSJTAlI>;
	Sat, 19 Oct 2002 20:41:08 -0400
Date: Sat, 19 Oct 2002 17:38:06 -0700 (PDT)
Message-Id: <20021019.173806.111570656.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021020000943.GL14009@conectiva.com.br>
References: <20021019233236.GI14009@conectiva.com.br>
	<20021019.165451.110952098.davem@redhat.com>
	<20021020000943.GL14009@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sat, 19 Oct 2002 21:09:43 -0300
   
   What about the CONFIG_IP_PROC_FS idea? Does it sounds reasonable or
   is it utter crap? :-)

I don't know, it might be useful for someone.

The question is if it is worth the effort ;)
