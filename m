Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRAXAQ7>; Tue, 23 Jan 2001 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131847AbRAXAQg>; Tue, 23 Jan 2001 19:16:36 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25152 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131466AbRAXAQW>; Tue, 23 Jan 2001 19:16:22 -0500
Message-ID: <3A6E1EB7.62B6256D@sgi.com>
Date: Tue, 23 Jan 2001 16:15:51 -0800
From: Florin Andrei <florin@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-lvs-1.0.3-reiserfs-3.5.29 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <200101232137.NAA02344@cx518206-b.irvn1.occa.home.com> <3A6E1C97.3B87EE00@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
> 
> The REAL problem was in disk performance.  The apm made no difference:

	Same problem here. I had a huge HDD performance drop when upgrading
from 2.2.18 to 2.4.0
	It's an Intel i815 motherboard, and the HDD is Ultra-ATA.

-- 
Florin Andrei
"Saying everything is a database is saying nothing at all
and certainly will not improve communication with others.
Database, database database. Database! See?" (Marc Lehmann)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
