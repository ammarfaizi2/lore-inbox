Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262931AbSJHWkW>; Tue, 8 Oct 2002 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbSJHWkW>; Tue, 8 Oct 2002 18:40:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262931AbSJHWkN>;
	Tue, 8 Oct 2002 18:40:13 -0400
Date: Tue, 08 Oct 2002 15:38:52 -0700 (PDT)
Message-Id: <20021008.153852.70461599.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: simon@baydel.com, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1034117581.31449.27.camel@irongate.swansea.linux.org.uk>
References: <1034076314.26473.47.camel@irongate.swansea.linux.org.uk>
	<20021008.130402.96131900.davem@redhat.com>
	<1034117581.31449.27.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 08 Oct 2002 23:53:01 +0100

   On Tue, 2002-10-08 at 21:04, David S. Miller wrote:
   > Actually, that driver was in the tree for a long time.
   
   Are you sure - the drivers for many things were, but not afaik the
   fddi one
   
I am absolutely sure, because I had this weirdo SBUS fddi card
using the AMD SUPERNET chipset just like the ap1000+ one did
and I was going to use their driver as a reference since it
was in the tree already.
