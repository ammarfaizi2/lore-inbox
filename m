Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272175AbRH3MLa>; Thu, 30 Aug 2001 08:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272173AbRH3MLT>; Thu, 30 Aug 2001 08:11:19 -0400
Received: from zeke.inet.com ([199.171.211.198]:26092 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S272170AbRH3MLF>;
	Thu, 30 Aug 2001 08:11:05 -0400
Message-ID: <3B8E2C35.1956DF51@inet.com>
Date: Thu, 30 Aug 2001 07:06:13 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Having problems with 2.4.9-ac
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reported having problems shuting down and rebooting my SMP
machine before.  Before the 2.4.8/9 series or ac kernels the last kernel
which could correctly reboot or shut down my machine had been
2.4.6-ac2.  I was very surprised when 2.4.8-ac10 was actually able to do
so as well.  If I issued any of the various commands to shut the box
down it would correctly get to the "Shutting down the machine" or
similar message and then issue Power Down and the box would go down,
also it would correctly get to the "Please wait while the machine
reboots..." and then would reboot.  Since 2.4.8-ac10 I have tried
2.4.8-ac12 as well as 2.4.9-ac1 and 2.4.9-ac3 none of which can
correctly reboot or shut down anymore.  What might the problem be?  I
don't want to go back to 2.4.8-ac10 if at all possible, 2.4.9-ac3 is one
of if not the most stable 2.4 kernel I have run in a long time.  Thank
you for whatever help you can give, let me know if I can provide more
data.

Jordan Breeding
