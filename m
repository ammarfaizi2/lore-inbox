Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUDEXWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDEXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:22:12 -0400
Received: from web21107.mail.yahoo.com ([216.136.227.109]:57938 "HELO
	web21107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263348AbUDEXWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:22:00 -0400
Message-ID: <20040405232158.76420.qmail@web21107.mail.yahoo.com>
Date: Mon, 5 Apr 2004 16:21:58 -0700 (PDT)
From: Steven Edwards <steven_ed4153@yahoo.com>
Subject: ReactOS and CoLinux status
To: Dan Aloni <da-x@colinux.org>,
       Cooperative Linux Development 
	<colinux-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040405131520.GA4395@callisto.yi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

If you want to run Linux and have your Windows device drivers then this
message is for you.

I just wanted to give all of you a update on our work to get CoLinux
working on ReactOS. Where it stands right now it looks like ReactOS
will be able to run CoLinux quite soon. We still have some issues with
running Cygwin applications so we need some help either fixing that or
we need to see if the CoLinux deamon can be built linking to msvcrt
rather than cygwin. Other than this the only show stopper we have atm
is our TCP/IP stack is still under heavy development and will not be
ready to run the Xserver and Linux network applications for another few
months.

Thanks
Steven


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
