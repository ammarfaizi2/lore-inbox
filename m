Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbREUOhW>; Mon, 21 May 2001 10:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261201AbREUOhN>; Mon, 21 May 2001 10:37:13 -0400
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:34187 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S261198AbREUOhG>; Mon, 21 May 2001 10:37:06 -0400
Date: Mon, 21 May 2001 22:36:58 +0800
From: Zou Min <zoum@comp.nus.edu.sg>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Simple question on kstat
Message-ID: <20010521223658.A2417@comp.nus.edu.sg>
Mail-Followup-To: Zou Min <zoum@comp.nus.edu.sg>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just want to clarify some fields in the "kstat" struct in kernel 2.4.
does "kstat.pgpgin" record all the real disk reads(not from buffer cache) ?
does "kstat.pswpin" record all the disk reads from swap partitions?
is "kstat.pswpin" already counted in "kstat.pgpgin"?

Thanks a lot!

-- 
Cheers!
--Zou Min 

zoum@comp.nus.edu.sg			URL: http://www.comp.nus.edu.sg/~zoum
-----------------------------------------------------------------------------
There is no sure cure to birth and death save to enjoy the interval.
		--George Santayana
