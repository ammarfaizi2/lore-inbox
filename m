Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRAZDxl>; Thu, 25 Jan 2001 22:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130754AbRAZDxb>; Thu, 25 Jan 2001 22:53:31 -0500
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:43392 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S130207AbRAZDxT>; Thu, 25 Jan 2001 22:53:19 -0500
Date: Thu, 25 Jan 2001 19:53:17 -0800
From: Dima Brodsky <dima@cs.ubc.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: mapping physical memory
Message-ID: <20010125195317.A2029@cascade.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to be able to obtain and pin approximately 8 MB of contiguous 
physical memory in user space.  How would I go about doing that under
Linux if it is at all possible?

Thanks
ttyl
Dima

-- 
Dima Brodsky                                   dima@cs.ubc.ca
                                               http://www.cs.ubc.ca/~dima
201-2366 Main Mall                             (604) 822-6179 (Office)
Department of Computer Science                 (604) 822-2895 (DSG Lab)
University of British Columbia, Canada         (604) 822-5485 (FAX)

Computers are like Old Testament gods; lots of rules and no mercy.
							  (Joseph Campbell)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
