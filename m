Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRKHVIH>; Thu, 8 Nov 2001 16:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRKHVH6>; Thu, 8 Nov 2001 16:07:58 -0500
Received: from stephens.ittc.ku.edu ([129.237.125.220]:43975 "EHLO
	stephens.ittc.ku.edu") by vger.kernel.org with ESMTP
	id <S278309AbRKHVHp>; Thu, 8 Nov 2001 16:07:45 -0500
Date: Thu, 8 Nov 2001 15:07:40 -0600 (CST)
From: Amit Kucheria <amitk@ittc.ku.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Way to dump kernel messages thru a funtion call ?
In-Reply-To: <200111081823.fA8IN1E11323@lists.us.dell.com>
Message-ID: <Pine.LNX.4.33.0111081454480.21717-100000@havoc.ittc.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to debug an oops mesg which isnt printing my debug printk 
statements. Is there a way to dump all kernel messages to the log files on 
a function call ?

Is sys_syslog() the way to do it ?

Regards,
Amit

-- 
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^
                  Amit Kucheria
          EECS Grad. Research Assistant
         University of Kansas @ Lawrence
   (R)+1-(785)-830 8521 ||| (O)+1-(785)-864 7774
____________________________________________________

