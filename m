Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319194AbSH2LTo>; Thu, 29 Aug 2002 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSH2LTo>; Thu, 29 Aug 2002 07:19:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319194AbSH2LTn>;
	Thu, 29 Aug 2002 07:19:43 -0400
Date: Thu, 29 Aug 2002 04:18:14 -0700 (PDT)
Message-Id: <20020829.041814.86991690.davem@redhat.com>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre5 more stable than 2.4.19???
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208291314.11638.roy@karlsbakk.net>
References: <200208291314.11638.roy@karlsbakk.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   Date: Thu, 29 Aug 2002 13:14:11 +0200

   David S. Miller tells me here that '2.4.20-pre5 is tons more stable than 
   2.4.19 anyways'
   
   is this correct?

If you're using the bonding driver, for one this.
It OOPS's in 2.4.19

There are other critical fixes in 2.4.20-preX as well.

Why is this news?  Stop the presses!  2.4.20-preX has more fixes than
2.4.19, how astonishing!
