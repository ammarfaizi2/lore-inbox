Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGQW6g>; Wed, 17 Jul 2002 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSGQW6g>; Wed, 17 Jul 2002 18:58:36 -0400
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:57286 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S316824AbSGQW6f>; Wed, 17 Jul 2002 18:58:35 -0400
Date: Wed, 17 Jul 2002 16:01:33 -0700
From: Dima Brodsky <dima@cs.ubc.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.26 problems on Sony Vaio R505DL
Message-ID: <20020717160133.A25474@aberlour.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to install kernel 2.5.26 on a Sony Vaio R505DL to
take advantage of the new implemented i830m driver.  The problem
I am seeing is that the keyboard and mouse does not work.  I can
login remotely and everything is fine.

If I cat /proc/interrupts I don't see any interrupts listed for
the keyboard or the mouse?

Any ideas??

Thanks
ttyl
Dima

-- 
Dima Brodsky                                   dima@cs.ubc.ca
                                               http://www.cs.ubc.ca/~dima
201-2366 Main Mall                             (604) 822-9156 (Office)
Department of Computer Science                 (604) 822-2895 (DSG Lab)
University of British Columbia, Canada         (604) 822-5485 (FAX)

"The price of reliability is the pursuit of the utmost simplicity.
 It is a price which the very rich find the most hard to pay."
						  (Sir Antony Hoare, 1980)

