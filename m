Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265386AbTFMNKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTFMNKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:10:06 -0400
Received: from jadzia.bu.edu ([128.197.20.189]:3498 "EHLO jadzia.bu.edu")
	by vger.kernel.org with ESMTP id S265386AbTFMNKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:10:05 -0400
Date: Fri, 13 Jun 2003 09:23:52 -0400
From: Matthew Miller <mattdm@mattdm.org>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030613132352.GA21383@jadzia.bu.edu>
References: <20030612042011$03c0@gated-at.bofh.it> <20030612062010$3dad@gated-at.bofh.it> <20030612193016$6d05@gated-at.bofh.it> <20030612193015$7974@gated-at.bofh.it> <20030613024549.078A4720B1@jadzia.bu.edu> <20030613105224.GA21277@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613105224.GA21277@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:52:24AM +0100, Dave Jones wrote:
>  > mistaken? (I.e. will having the kernel support this be a huge performance
>  > increase?) Thanks!
> performance-wise, it may make a small difference on SMP systems, as it
> affects the balancing of the scheduler. On UP, shouldn't be any difference.

Ok, thanks. It's not an SMP subnotebook. :)

-- 
Matthew Miller           mattdm@mattdm.org        <http://www.mattdm.org/>
Boston University Linux      ------>                <http://linux.bu.edu/>
