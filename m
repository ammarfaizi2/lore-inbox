Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbRE0JGk>; Sun, 27 May 2001 05:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbRE0JGa>; Sun, 27 May 2001 05:06:30 -0400
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:28582 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S261302AbRE0JGX>; Sun, 27 May 2001 05:06:23 -0400
Date: Sun, 27 May 2001 17:06:11 +0800
From: Zou Min <zoum@comp.nus.edu.sg>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [newbie question] disk reads for a process
Message-ID: <20010527170611.A10091@comp.nus.edu.sg>
Mail-Followup-To: Zou Min <zoum@comp.nus.edu.sg>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am doing a research on an analytical model that describes how memory size
affects disk reads. We have done intensive measurement to validate the model.
Now, we are intereseted in another intepretation of this model as relating
memory allocation to disk reads for a process.

To validate this, we need to 
* identify private working sets of each processes
* identify initiators of disk reads
* count the number of disk reads for one process

Can anybody give me some direct pointers on the above?
Which part of the source code should be alerted?

Your help is greatly appreciated!

-- 
Cheers!
--Zou Min 
