Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281659AbRKZMzu>; Mon, 26 Nov 2001 07:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281662AbRKZMze>; Mon, 26 Nov 2001 07:55:34 -0500
Received: from web14504.mail.yahoo.com ([216.136.224.67]:56842 "HELO
	web14504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281660AbRKZMzS>; Mon, 26 Nov 2001 07:55:18 -0500
Message-ID: <20011126125517.27715.qmail@web14504.mail.yahoo.com>
Date: Mon, 26 Nov 2001 04:55:17 -0800 (PST)
From: sekhar raja <manamraja@yahoo.com>
Subject: Doubt in Kernel Timers
To: linux-kernel@vger.kernel.org
Cc: manamraja@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks

I have a doubt in Kernel Timers, Can we delete the
Timer with out adding it to the timer List.

What do i mean is with out Doing add_timer() can we
use del_timer(). 

If we can not do that, how do we check whether the
particular timer is running or not. 

Your help will be greatly Appreciated, Please CC me
the Answer as i am not Subscribe to the mailing list.

Thanks in Advance
-Rajasekhar 

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
