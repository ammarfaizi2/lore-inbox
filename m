Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278582AbRJXPYx>; Wed, 24 Oct 2001 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278578AbRJXPYn>; Wed, 24 Oct 2001 11:24:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16010 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278568AbRJXPYc>;
	Wed, 24 Oct 2001 11:24:32 -0400
Date: Wed, 24 Oct 2001 08:24:32 -0700 (PDT)
Message-Id: <20011024.082432.28404397.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: baggins@sith.mimuw.edu.pl, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, jes@trained-monkey.org
Subject: Re: acenic breakage in 2.4.13-pre
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BD6D6AC.B9CF58EB@mandrakesoft.com>
In-Reply-To: <20011024164533.C15474@sith.mimuw.edu.pl>
	<3BD6D6AC.B9CF58EB@mandrakesoft.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 24 Oct 2001 10:56:44 -0400
   
   Several people have reported this bug.
   
   Alexey, are the 2.4.13 acenic changes yours?  You had mentioned hacking
   on it...  Jes, the maintainer, is CC'd too.

It's not Jes's changes, it's the pci64 bits I did.

Franks a lot,
David S. Miller
davem@redhat.com
