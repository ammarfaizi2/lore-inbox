Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281462AbRKHEkp>; Wed, 7 Nov 2001 23:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKHEke>; Wed, 7 Nov 2001 23:40:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5518 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281462AbRKHEkX>;
	Wed, 7 Nov 2001 23:40:23 -0500
Date: Wed, 07 Nov 2001 20:39:54 -0800 (PST)
Message-Id: <20011107.203954.118627544.davem@redhat.com>
To: adilger@turbolabs.com
Cc: tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011107213218.U5922@lynx.no>
In-Reply-To: <20011107173626.S5922@lynx.no>
	<20011107.164426.35502643.davem@redhat.com>
	<20011107213218.U5922@lynx.no>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Dilger <adilger@turbolabs.com>
   Date: Wed, 7 Nov 2001 21:32:18 -0700

   I don't see that it harms anything to use the macros instead.

Maybe if this code were literally etched into the back your skull like
it is for some of us, you'd understand what a detriment it is to make
changes like this when it isn't necessary :-)

Franks a lot,
David S. Miller
davem@redhat.com

