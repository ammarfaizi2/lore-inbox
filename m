Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263584AbRFKPC4>; Mon, 11 Jun 2001 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFKPCg>; Mon, 11 Jun 2001 11:02:36 -0400
Received: from web3505.mail.yahoo.com ([216.115.111.72]:4878 "HELO
	web3505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263404AbRFKPC1>; Mon, 11 Jun 2001 11:02:27 -0400
Message-ID: <20010611150226.7989.qmail@web3505.mail.yahoo.com>
Date: Mon, 11 Jun 2001 16:02:26 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: Clock drift with Transmeta Crusoe
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Searching through the mailing list I could not find a
reference to this problem, hence this post.

Having ran various kernel and distribution
combinations (SGI's 2.4.2-xfs bundled with their Red
Hat installer, 2.4-xfs-1.0 and 2.4 CVS trees, Linux
Mandrake with default kernel 2.4.3, and lastly
2.4.5-ac9), compiled for generic i386 and/or Transmeta
Crusoe with APM off or on, one thing sticks out : a
clock drift of a few minutes per day.

This problem might not be noticeable for most users
since notebooks are not normally left running that
long, but it is rather serious. I can choose not to
sync the software and hardware clock on shutdown and
re-read the hardware clock every hour or so but it is
rather kludgy.

Anyone experienced this before or willing to try it
out?

Regards,

Michel

PS sorry for the previous post without subject, hit
the send button accidentally

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
