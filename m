Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281232AbRKHBhP>; Wed, 7 Nov 2001 20:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281241AbRKHBhG>; Wed, 7 Nov 2001 20:37:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37772 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281261AbRKHBg7>;
	Wed, 7 Nov 2001 20:36:59 -0500
Date: Wed, 07 Nov 2001 17:36:49 -0800 (PST)
Message-Id: <20011107.173649.94552736.davem@redhat.com>
To: tim@physik3.uni-rostock.de
Cc: adilger@turbolabs.com, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111080216250.30014-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <20011107.170940.10246156.davem@redhat.com>
	<Pine.LNX.4.30.0111080216250.30014-100000@gans.physik3.uni-rostock.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Schmielau <tim@physik3.uni-rostock.de>
   Date: Thu, 8 Nov 2001 02:20:02 +0100 (CET)
   
   They actually are necessary as unsigned values can never become less than
   zero.

I definitely stand corrected.

Franks a lot,
David S. Miller
davem@redhat.com
