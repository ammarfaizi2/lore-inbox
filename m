Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131704AbRAAIxM>; Mon, 1 Jan 2001 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRAAIxC>; Mon, 1 Jan 2001 03:53:02 -0500
Received: from bill.trinity.unimelb.edu.au ([203.28.240.2]:38150 "HELO
	bill.trinity.unimelb.edu.au") by vger.kernel.org with SMTP
	id <S131704AbRAAIwt>; Mon, 1 Jan 2001 03:52:49 -0500
Date: Mon, 1 Jan 2001 19:22:15 +1100
From: Tim Bell <bhat@trinity.unimelb.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops using mke2fs on software raid-0 with pre7
Message-ID: <20010101192215.A30076@trinity.unimelb.edu.au>
In-Reply-To: <20001231160323.A15940@trinity.unimelb.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001231160323.A15940@trinity.unimelb.edu.au>; from bhat@trinity.unimelb.edu.au on Sun, Dec 31, 2000 at 04:03:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> Oops while using mke2fs on software raid-0 device with pre7.

After extensive testing of different configurations and many more
oopsen, I've found that this was due to memory errors.  Sorry if I
wasted anyone's time.

Tim.
-- 
Tim Bell - bhat@trinity.unimelb.edu.au - System Administrator & Programmer
    Trinity College, Royal Parade, Parkville, Victoria, 3052, Australia
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
