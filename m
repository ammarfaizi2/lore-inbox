Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRCMMMM>; Tue, 13 Mar 2001 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130616AbRCMMMC>; Tue, 13 Mar 2001 07:12:02 -0500
Received: from gemini.tcg-software.com ([208.221.13.100]:31500 "HELO
	gemini.tcg-software.com") by vger.kernel.org with SMTP
	id <S130487AbRCMMLq>; Tue, 13 Mar 2001 07:11:46 -0500
X-Lotus-FromDomain: TCG-SOFTWARE
From: "Rajiv Majumdar" <rmajumda@tcg-software.com>
To: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <65256A0E.004386D6.00@gemini.tcg-software.com>
Date: Tue, 13 Mar 2001 17:47:33 +0530
Subject: Re: system call for process information?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




every process under Linux is assigned a *task_struct* structure which has
all the info about that process eg. scheduling, accounting, I/O and others.

rajiv




Guennadi Liakhovetski <g.liakhovetski@ragingbull.com> on 03/12/2001
10:38:46 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Rajiv Majumdar/CAL/NOTES)

Subject:  system call for process information?




Hello

I asked this question on kernel-newbies - no reply, hope to be luckier
here:-)

I need to collect some info on processes. One way is to read /proc
tree. But isn't there a system call (ioctl) for this? And what are those
task[], task_struct, etc. about?

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


-
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/
IRC Channel:   irc.openprojects.net / #kernelnewbies
Web Page:      http://www.surriel.com/kernelnewbies.shtml

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




