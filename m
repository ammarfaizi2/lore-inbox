Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264087AbRFKLgW>; Mon, 11 Jun 2001 07:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264088AbRFKLgM>; Mon, 11 Jun 2001 07:36:12 -0400
Received: from web3504.mail.yahoo.com ([216.115.111.71]:17415 "HELO
	web3504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264087AbRFKLgF>; Mon, 11 Jun 2001 07:36:05 -0400
Message-ID: <20010611113604.4073.qmail@web3504.mail.yahoo.com>
Date: Mon, 11 Jun 2001 12:36:04 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: Clock drift on Transmeta Crusoe
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

Any suggestions and/or user experiences more than
welcome.

Regards,

Michel

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
