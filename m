Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264930AbSJ3WkA>; Wed, 30 Oct 2002 17:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbSJ3WkA>; Wed, 30 Oct 2002 17:40:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24766 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264930AbSJ3Wj7>;
	Wed, 30 Oct 2002 17:39:59 -0500
Date: Wed, 30 Oct 2002 14:36:15 -0800 (PST)
Message-Id: <20021030.143615.10738219.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: boissiere@adiglobal.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021031.005535.67557509.yoshfuji@linux-ipv6.org>
References: <3DBFB0D2.21734.21E3A6B@localhost>
	<20021031.005535.67557509.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 31 Oct 2002 00:55:35 +0900 (JST)

   > o in 2.5.45  IPsec support  (Alexey Kuznetsov, Dave Miller, USAGI team)  
   
   How is the status of IPsec for IPv6?
   
It will be done after ipv4 side is fully functional.
   
     - IPv6 source address selection; which will be mandated by the 
       node requirement.

We told you several times how this USAGI patch is not currently in an
acceptable form and needs to be reimplemented via the routing code.

     - IPsec for IPv6

Alexey and I will implement this, it is basically reading RFCs and
typing at the keyboard, no more.

     - several enhancements on specification conformity
       (neighbour discovery etc.)

Where are these patches?  I've applied everything you've submitted.
