Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRHPXkS>; Thu, 16 Aug 2001 19:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269104AbRHPXkI>; Thu, 16 Aug 2001 19:40:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29568 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269101AbRHPXj4>;
	Thu, 16 Aug 2001 19:39:56 -0400
Date: Thu, 16 Aug 2001 16:38:52 -0700 (PDT)
Message-Id: <20010816.163852.115909286.davem@redhat.com>
To: aia21@cam.ac.uk
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk>
In-Reply-To: <20010816144109.A5094@cb.vato.org>
	<20010816.153151.74749641.davem@redhat.com>
	<5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Altaparmakov <aia21@cam.ac.uk>
   Date: Fri, 17 Aug 2001 00:22:43 +0100
   
   IMHO, it would have been more elegant to use the typeof construct provided 
   by gcc in the new macro instead of introducing a type parameter like this...

The whole point was to make users explicitly state the type so they
would have to think about it.

Later,
David S. Miller
davem@redhat.com
