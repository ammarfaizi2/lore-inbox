Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTAFVXH>; Mon, 6 Jan 2003 16:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbTAFVXH>; Mon, 6 Jan 2003 16:23:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:63134 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267158AbTAFVXG>; Mon, 6 Jan 2003 16:23:06 -0500
Date: Mon, 06 Jan 2003 13:23:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Avery Fay <avery_fay@symantec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
Message-ID: <35670000.1041888203@flay>
In-Reply-To: <OF56E8EAC6.7DEBE879-ON85256CA6.007042A6-85256CA6.0070AD35@symantec.com>
References: <OF56E8EAC6.7DEBE879-ON85256CA6.007042A6-85256CA6.0070AD35@symantec.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, judging by the fact that a UP kernel can route more traffic (and 
> consequently more interrupts p/s) than an SMP kernel, I think that one cpu 

Umm ... what are you comparing here? How many CPUs on your SMP kernel?
If I have an 8 CPU machine, you think it can handle less traffic than
a 1-cpu machine running a UP kernel?

> can probably handle all of the interrupts. Really the issue I'm trying to 
> solve is not routing performance, but rather the fact that SMP routing 
> performance is worse while using twice the cpu time (2 cpu's at around 95% 
> vs. 1 at around 95%).

Can you mail out kernel profiles? What's burning all the time here?

Thanks,

M.

