Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274427AbRJEXKg>; Fri, 5 Oct 2001 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJEXK0>; Fri, 5 Oct 2001 19:10:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274405AbRJEXKO>;
	Fri, 5 Oct 2001 19:10:14 -0400
Date: Fri, 05 Oct 2001 16:10:24 -0700 (PDT)
Message-Id: <20011005.161024.104033411.davem@redhat.com>
To: kernel@ddx.a2000.nu
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.rutgers.edu
Subject: Re: sun + gigabit nic
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40.0110051319300.4011-100000@ddx.a2000.nu>
In-Reply-To: <Pine.LNX.4.40.0110051319300.4011-100000@ddx.a2000.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kernel@ddx.a2000.nu
   Date: Fri, 5 Oct 2001 13:22:40 +0200 (CEST)

   for my sun ultrasparc 10 with linux i wanted to upgrade to a gigabit card
   but when looking in the menuconfig i only see : (kernel 2.2.20pre10)
   
   MyriCOM Gigabit Ethernet support
   
   does anyone know which cards are supported ? (with patches?)
   it has to be 1000base-T
   
No patches needed, 2.2.x (and 2.4.x) supports Syskonnect gigabit cards
out of the box.

Acenic is supported in 2.4.x, although I don't know why not in 2.2.x
as that should be trivial to make work...

Franks a lot,
David S. Miller
davem@redhat.com
