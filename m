Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSLJMpt>; Tue, 10 Dec 2002 07:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSLJMpt>; Tue, 10 Dec 2002 07:45:49 -0500
Received: from web10305.mail.yahoo.com ([216.136.130.83]:20819 "HELO
	web10305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261368AbSLJMps>; Tue, 10 Dec 2002 07:45:48 -0500
Message-ID: <20021210125332.69872.qmail@web10305.mail.yahoo.com>
Date: Tue, 10 Dec 2002 12:53:32 +0000 (GMT)
From: "=?iso-8859-1?q?J.D.=20Hood?=" <jdthood@yahoo.co.uk>
Subject: Re: 2.4.20-ac1 hangs IBM Thinkpad
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have also stopped using 2.4.20-ac1 on my ThinkPad.
It performs much worse than 2.4.20-pre8-ac1 when running
large applications such as OpenOffice.  (It never crashed
on me, though.)  Having read the recent thread on changes
to the scheduler and yield(), I suspect that the problem
is related to that, since the 2.4-ac series has the O(1)
scheduler.

If my suspicion is correct, then I concur with the opinion
that O(1) should not be backported to mainline 2.4.

--
Thomas Hood

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
