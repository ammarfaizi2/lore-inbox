Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbRCIGRm>; Fri, 9 Mar 2001 01:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRCIGRc>; Fri, 9 Mar 2001 01:17:32 -0500
Received: from kwanon.research.canon.com.au ([203.12.172.254]:46097 "HELO
	kwanon.research.canon.com.au") by vger.kernel.org with SMTP
	id <S130436AbRCIGR2>; Fri, 9 Mar 2001 01:17:28 -0500
Message-ID: <20010309061700.17719.qmail@cass.research.canon.com.au>
From: gjohnson@research.canon.com.au
Subject: Re: Resolving physical addresses
To: davem@redhat.com (David S. Miller)
Date: Fri, 9 Mar 2001 17:17:00 +1100 (EST)
Cc: gjohnson@research.canon.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <15016.29137.743441.608694@pizda.ninka.net> from "David S. Miller" at Mar 08, 2001 10:01:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you,

But how do I get the physical address out of the page
structure? It is non-obvious to me. Is there some majic
macro? We are talking about 'struct page' in mm.h, correct?

Greg.

Quoth David S. Miller:
> In 2.4.x pte_page() gives a pointer to a page struct, not an address
> as in 2.2.x.

-- 
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

