Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTJFS0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTJFS0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:26:50 -0400
Received: from web13005.mail.yahoo.com ([216.136.174.15]:6667 "HELO
	web13005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264022AbTJFS0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:26:47 -0400
Message-ID: <20031006182646.21266.qmail@web13005.mail.yahoo.com>
Date: Mon, 6 Oct 2003 19:26:46 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Davies?= <mnni2001@yahoo.co.uk>
Subject: [2.6.0-test6]  Alsa problem with Via 8235
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I having trouble with the my Via 8235 chipset and the
latest kernel.

Sound works sometimes for a minute or so, but most of
the time I just get a lot of random noise
(hissing/crackling etc)rather than any audio.

I noticed I'm getting the following error in dsmseg:

via82xx: Assuming DXS channels with 48k fixed sample
rate. Please try dxs_support=1 option and report if it
works on your machine.

I tried adding a dxs_support=1 option in modules.conf,
but it made no difference to the sound problem.

I've also tried playing around with the mixer
settings, but no matter what I set them to I still get
the same problem.




________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk
