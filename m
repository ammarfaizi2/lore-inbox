Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136700AbREGWxw>; Mon, 7 May 2001 18:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136699AbREGWxl>; Mon, 7 May 2001 18:53:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38058 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136700AbREGWxY>;
	Mon, 7 May 2001 18:53:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.10082.285131.289903@pizda.ninka.net>
Date: Mon, 7 May 2001 15:53:22 -0700 (PDT)
To: Sean Jones <sjones@ossm.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPARC include problem
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sean Jones writes:
 > In compiling 2.4.4-ac5 for my SPARCStation 20, I had an error in the
 > compile resulting from the inability to find a hw_irq.h in the
 > include/asm directory. Do you know where I may be able to find such a
 > file?

How did you find this problem if the build couldn't find the
"bzImage" rule? :-)

Later,
David S. Miller
davem@redhat.com
