Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUI0QIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUI0QIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUI0QIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:08:20 -0400
Received: from web40708.mail.yahoo.com ([66.218.78.165]:29532 "HELO
	web40708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266485AbUI0QIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:08:09 -0400
Message-ID: <20040927160807.80266.qmail@web40708.mail.yahoo.com>
Date: Mon, 27 Sep 2004 09:08:07 -0700 (PDT)
From: Timothy Miller <theosib@yahoo.com>
Subject: Using certain graphics cards on non-x86 systems?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a quick question.  There are certain devices, like graphics
cards, which require that their BIOS be run at POST in order to
initialize certain critical (and often undocumented) bits of their
hardware before they can be used by the OS.  What does Linux do about
that on non-x86 systems?  I remember old Alphas had like and 8088
emulator that allowed SOME PC graphics cards to be used as a console
even.  But on, say, a G5, are you out of luck?  Is there an x86
emulator that you use to run the BIOS?  At what stage is it run so that
you can have a console?  Many cards can't even do basic VGA without the
BIOS first being run.

Thanks.



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
