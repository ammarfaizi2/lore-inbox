Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271942AbRH2JsN>; Wed, 29 Aug 2001 05:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271943AbRH2JsC>; Wed, 29 Aug 2001 05:48:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41091 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271942AbRH2Jrq>;
	Wed, 29 Aug 2001 05:47:46 -0400
Date: Wed, 29 Aug 2001 02:48:00 -0700 (PDT)
Message-Id: <20010829.024800.115907662.davem@redhat.com>
To: david.balazic@uni-mb.si
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.9 , "illegal" MIN and MAX macros spotted
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B8CB369.1BFCE73E@uni-mb.si>
In-Reply-To: <3B8CB369.1BFCE73E@uni-mb.si>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Balazic <david.balazic@uni-mb.si>
   Date: Wed, 29 Aug 2001 11:18:33 +0200

   in drivers/media/video/saa5249.c, line 125 :

Known... I plan a MIN/MAX scan over the tree soon.
Every serial driver in fact has this.

Later,
David S. Miller
davem@redhat.com
