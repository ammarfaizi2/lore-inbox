Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135530AbRAGBV6>; Sat, 6 Jan 2001 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135531AbRAGBVj>; Sat, 6 Jan 2001 20:21:39 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:15472 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S135503AbRAGBVd>;
	Sat, 6 Jan 2001 20:21:33 -0500
Message-ID: <3A57C442.C3AE831@cs.cmu.edu>
Date: Sat, 06 Jan 2001 20:20:02 -0500
From: Sourav Ghosh <sourav@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.15-timesys-1.2.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sourav@cs.cmu.edu
Subject: Speed of the network card
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was wondering how I can determine the speed of a network device inside
the kernel.

In case of ethernet, the "name" field  of device structure will only
give eth0 or something. But the speed could be either 10Mbps or 100Mbps.

Thanks,

--
Sourav


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
