Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLUBS1>; Wed, 20 Dec 2000 20:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQLUBSS>; Wed, 20 Dec 2000 20:18:18 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:17440
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129601AbQLUBSK>; Wed, 20 Dec 2000 20:18:10 -0500
Date: Wed, 20 Dec 2000 16:47:42 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: fs corruption in 2.4.0-test11?
Message-ID: <20001220164742.A3756@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just need a sanity check - do other pages/blocks sometimes show up in
recently created files in 2.4.0-test11?

I have a (so far) non-reproducible case where the wrong data showed up in
a new file.  The nice part is that it was when I was imploding a large
BitKeeper patch so I can run the test case over and over if that would 
help find it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
