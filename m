Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264464AbRFORFi>; Fri, 15 Jun 2001 13:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbRFORF3>; Fri, 15 Jun 2001 13:05:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32443 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264456AbRFORFQ>;
	Fri, 15 Jun 2001 13:05:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15146.16442.250756.644292@pizda.ninka.net>
Date: Fri, 15 Jun 2001 10:04:58 -0700 (PDT)
To: Petko Manolov <pmanolov@Lnxw.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc
In-Reply-To: <3B2A3F90.799ACAC4@lnxw.com>
In-Reply-To: <3B2A3F90.799ACAC4@lnxw.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petko Manolov writes:
 > kmalloc fails to allocate more than 128KB of
 > memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
 > 
 > Any ideas?

Yes, this is the limit.

Later,
David S. Miller
davem@redhat.com
