Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSEJQC0>; Fri, 10 May 2002 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316045AbSEJQCZ>; Fri, 10 May 2002 12:02:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63936 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316052AbSEJQCB>;
	Fri, 10 May 2002 12:02:01 -0400
Date: Fri, 10 May 2002 08:49:48 -0700 (PDT)
Message-Id: <20020510.084948.99859388.davem@redhat.com>
To: nharring@hostway.net
Cc: jgarzik@mandrakesoft.com, pmanuel@myrealbox.com, chen_xiangping@emc.com,
        linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CDBEC6A.9020600@hostway.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nicholas Harring <nharring@hostway.net>
   Date: Fri, 10 May 2002 10:51:06 -0500

   And how about when an SMP system isn't enough?

Demonstrate this.

Putting the whole implementation on the cards firmware is feasible,
you don't need SMP.  It's totally doable and Linux needs to see
none of the details.

Franks a lot,
David S. Miller
davem@redhat.com
