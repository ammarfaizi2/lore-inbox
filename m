Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRGFXyg>; Fri, 6 Jul 2001 19:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRGFXy0>; Fri, 6 Jul 2001 19:54:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50152 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262634AbRGFXyJ>;
	Fri, 6 Jul 2001 19:54:09 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.20383.84051.790269@pizda.ninka.net>
Date: Fri, 6 Jul 2001 16:54:07 -0700 (PDT)
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <200107061724.NAA14777@smarty.smart.net>
In-Reply-To: <200107061724.NAA14777@smarty.smart.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rick Hohensee writes:
 > Forth chips aren't modern in the true-multi-user sense, but if an
 > individual were to design such a beast they could get several of them,
 > hundreds maybe, on FPGAs available now. Such things are coming, because a 
 > Forth chip IS something an individual can design.

And I suppose this zero-cost call is also handling things like keeping
an N stage deep pipeline full during this call right?

Later,
David S. Miller
davem@redhat.com
