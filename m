Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbRBNWLk>; Wed, 14 Feb 2001 17:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131771AbRBNWLb>; Wed, 14 Feb 2001 17:11:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129661AbRBNWLS>; Wed, 14 Feb 2001 17:11:18 -0500
Subject: Re: 2.4.1-ac13 tulip problems
To: faceprint@faceprint.com (Nathan Walp)
Date: Wed, 14 Feb 2001 22:11:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8B019C.4F0C76DB@faceprint.com> from "Nathan Walp" at Feb 14, 2001 05:07:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TA9M-0006FE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just booted to 2.4.1-ac13, and was fine for a couple minutes.  Then
> all network connectivity went away, and I had this sitting in syslog:
> Hence, I'm back to 2.4.1-ac12, and sending this in.  No other noticible
> problems in my short-lived uptime ;-)

I guess the pnic fixes have a side effect we didnt want. What kind of tulip
do you have (lspci -v ?)
