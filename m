Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267718AbRGZKan>; Thu, 26 Jul 2001 06:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbRGZKae>; Thu, 26 Jul 2001 06:30:34 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:10759 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267718AbRGZKaN>; Thu, 26 Jul 2001 06:30:13 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: DAC module in 2.4.7 buggered
Date: Thu, 26 Jul 2001 22:28:55 +1200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072622285501.00924@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I was just compiling 2.4.7 a couple of days ago, and DAC that is located in 
block devices (just below the compaq raid things in the configmenu) fails to 
compile as a module.

I removed it, and everything went alright.

Although I don't need it, I thought I might as well inform the kernel guru's 
of this error that may be affecting other users.

Matthew Gardiner
-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

