Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286683AbRLVFH6>; Sat, 22 Dec 2001 00:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286684AbRLVFHs>; Sat, 22 Dec 2001 00:07:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10138 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286683AbRLVFHj>;
	Sat, 22 Dec 2001 00:07:39 -0500
Date: Fri, 21 Dec 2001 21:06:55 -0800 (PST)
Message-Id: <20011221.210655.91756024.davem@redhat.com>
To: pizza@shaftnet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - 2.4.17 - if_arp.h - Add the Prism2 ARP type
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011222000105.A22554@shaftnet.org>
In-Reply-To: <20011222000105.A22554@shaftnet.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stuffed Crust <pizza@shaftnet.org>
   Date: Sat, 22 Dec 2001 00:01:05 -0500

   Hey, this one-line patch (I diffed it against 2.4.17-rc2) defines the
   ARPHRD_IEEE80211_PRISM arp type.

Is the allocation of this number standardized somewhere?
