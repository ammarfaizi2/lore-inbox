Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263908AbRFIXNW>; Sat, 9 Jun 2001 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263916AbRFIXNM>; Sat, 9 Jun 2001 19:13:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17288 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263908AbRFIXM4>;
	Sat, 9 Jun 2001 19:12:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15138.44403.815959.756121@pizda.ninka.net>
Date: Sat, 9 Jun 2001 16:12:51 -0700 (PDT)
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable endianess problem in TLAN driver
In-Reply-To: <Pine.LNX.4.33.0106092356360.23184-100000@infradead.org>
In-Reply-To: <15138.42357.146305.892652@pizda.ninka.net>
	<Pine.LNX.4.33.0106092356360.23184-100000@infradead.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Riley Williams writes:
 > Even if that wasn't true, aren't the above all self-recursive
 > definitions that would prevent anything calling them from compiling?

Yes, it looks that way.

Later,
David S. Miller
davem@redhat.com
