Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269465AbRHQClx>; Thu, 16 Aug 2001 22:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269489AbRHQCln>; Thu, 16 Aug 2001 22:41:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3969 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269465AbRHQClg>;
	Thu, 16 Aug 2001 22:41:36 -0400
Date: Thu, 16 Aug 2001 19:38:41 -0700 (PDT)
Message-Id: <20010816.193841.98557608.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7C8196.10D1C867@linux-m68k.org>
In-Reply-To: <3B7C7235.1E09C034@linux-m68k.org>
	<20010816.185018.102580124.davem@redhat.com>
	<3B7C8196.10D1C867@linux-m68k.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Fri, 17 Aug 2001 04:29:42 +0200
   
   Why would you want something different?

Because comparing a signed value with an unsigned value is a perfectly
sane operation and one should not have to put dumb casts into the
expression or change the types just to avoid a compiler warning.

That's dumb.

Later,
David S. Miller
davem@redhat.com
