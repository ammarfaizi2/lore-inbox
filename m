Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbRLFKQP>; Thu, 6 Dec 2001 05:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285101AbRLFKQF>; Thu, 6 Dec 2001 05:16:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34181 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285099AbRLFKPv>;
	Thu, 6 Dec 2001 05:15:51 -0500
Date: Thu, 06 Dec 2001 02:15:34 -0800 (PST)
Message-Id: <20011206.021534.66178457.davem@redhat.com>
To: dwmw2@infradead.org
Cc: jgarzik@mandrakesoft.com, kaos@ocs.com.au, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15133.1007631619@redhat.com>
In-Reply-To: <11777.1007619756@kao2.melbourne.sgi.com>
	<3C0F27CA.59C22DEF@mandrakesoft.com>
	<15133.1007631619@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Thu, 06 Dec 2001 09:40:19 +0000
   
   Doesn't work at all, or just doesn't work with the (current) minimum
   recommended compiler? We have to increase those minima at some point. 

The "golden" sparc64 compiler has been in use for years and is what
has the weak problem, and updating it would be a major pain in the
butt.
