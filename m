Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267305AbRGKNJz>; Wed, 11 Jul 2001 09:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbRGKNJp>; Wed, 11 Jul 2001 09:09:45 -0400
Received: from web11607.mail.yahoo.com ([216.136.172.59]:39953 "HELO
	web11607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267305AbRGKNJZ>; Wed, 11 Jul 2001 09:09:25 -0400
Message-ID: <20010711130926.22422.qmail@web11607.mail.yahoo.com>
Date: Wed, 11 Jul 2001 15:09:26 +0200 (CEST)
From: =?iso-8859-1?q?Er-Vin?= <er_vin@yahoo.com>
Reply-To: er_vin@yahoo.com
Subject: Very Urgent : PPP multilink + H323 project
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a project using multilink connection
but are having some problems with multilink PPP.

We are trying to bind 8 analog modem chanels(not ISDN)
with PPP. The protocol work's right when we use ftp
but when we are using ohphone(openh323 project) to
transmit video connection breaks and the kernel spams
the console with the message "Warning : kfree_skb on
hard IRQ c8a53545".

If someone has a solution, a patch for kernel 2.4.5 or
something else, please contact me at ervin@yahoo.com
or at the mailing list.

Best regards.

ervin

___________________________________________________________
Do You Yahoo!? -- Pour faire vos courses sur le Net, 
Yahoo! Shopping : http://fr.shopping.yahoo.com
