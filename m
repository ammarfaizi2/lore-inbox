Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbRAXDsl>; Tue, 23 Jan 2001 22:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131035AbRAXDsb>; Tue, 23 Jan 2001 22:48:31 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:36349 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130320AbRAXDs0>; Tue, 23 Jan 2001 22:48:26 -0500
Message-ID: <3A6E507F.21E518DE@yahoo.co.uk>
Date: Tue, 23 Jan 2001 22:48:15 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: With recent kernels, ThinkPad 600 won't resume for two minutes after 
 suspend
In-Reply-To: <393D1B6D.ECCE0721@mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

With recent kernels, my ThinkPad 600 won't resume for two minutes
after it is suspended.  When the Fn key is pressed the machine
starts up, the CD-ROM scans, the screen backlight turns on,
and the APM light flashes.  But then it just stays like that
instead of restarting the CPU; it is completely hung, although
the APM light continues to flash.  If I wait more than about
two minutes with the machine suspended, however, then everything
resumes normally.

I have been running Linux for two years.  This never happened
before a couple weeks ago when I upgraded to kernels 2.2.18 and
then 2.4.0 .  I have since tested kernel 2.2.17 and see the
same problem.  Do I have a hardware problem, or might something
have changed in the kernel that could lead to this behavior?

Thomas Hood
jdthood_AT_yahoo.co.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
