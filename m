Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284368AbRLCIvt>; Mon, 3 Dec 2001 03:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284364AbRLCIte>; Mon, 3 Dec 2001 03:49:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58519 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284398AbRLBXWM>;
	Sun, 2 Dec 2001 18:22:12 -0500
Date: Sun, 02 Dec 2001 15:21:57 -0800 (PST)
Message-Id: <20011202.152157.123925377.davem@redhat.com>
To: kaos@ocs.com.au
Cc: hps@intermeta.de, jgarzik@mandrakesoft.com, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <10605.1007169423@ocs3.intra.ocs.com.au>
In-Reply-To: <1007140529.6655.37.camel@forge>
	<10605.1007169423@ocs3.intra.ocs.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Sat, 01 Dec 2001 12:17:03 +1100
   
   What is ugly in aic7xxx is :-

You missed:

* #undef's "current"
