Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274710AbRIUAAZ>; Thu, 20 Sep 2001 20:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274711AbRIUAAP>; Thu, 20 Sep 2001 20:00:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34698 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274710AbRITX75>;
	Thu, 20 Sep 2001 19:59:57 -0400
Date: Thu, 20 Sep 2001 16:59:53 -0700 (PDT)
Message-Id: <20010920.165953.102611286.davem@redhat.com>
To: acme@conectiva.com.br
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH][RFC] spin_trylock_bh
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010915172659.A1916@conectiva.com.br>
In-Reply-To: <20010915172659.A1916@conectiva.com.br>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sat, 15 Sep 2001 17:26:59 -0300

   	Please see if this is acceptable, I noticed this while working on
   the locks for NetBEUI 8) Patch is against 2.4.9, but it should apply to
   latest prepatch. It was being used in the ppp code for quite some time.
   
This patch looks fine to me...

Later,
David S. Miller
davem@redhat.com
