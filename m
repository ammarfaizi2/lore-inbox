Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265726AbSKAUAM>; Fri, 1 Nov 2002 15:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265739AbSKAUAM>; Fri, 1 Nov 2002 15:00:12 -0500
Received: from mpls-qmqp-01.inet.qwest.net ([63.231.195.112]:54026 "HELO
	mpls-qmqp-01.inet.qwest.net") by vger.kernel.org with SMTP
	id <S265726AbSKAUAB>; Fri, 1 Nov 2002 15:00:01 -0500
Date: Fri, 1 Nov 2002 12:06:24 -0800
Message-Id: <02110112062400.01200@rigel>
From: "Steven King" <sxking@qwest.net>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Joel Becker" <Joel.Becker@oracle.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Bill Davidsen" <davidsen@tmr.com>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Content-Type: text/plain; charset=US-ASCII
Subject: Re: What's left over.
X-Mailer: KMail [version 1.2]
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 11:18 am, Linus Torvalds wrote:

> To add insult to injury, you will not be able to actually _test_ any of
> the real error paths in real life. Sure, you will be able to test forced
> dumps on _your_ hardware, but while that is fine in the AIX model ("we
> control the hardware, and charge the user five times what it is worth"),
> again that doesn't mean _squat_ in the PC hardware space.

  On the other hand, ISC's system 5 r3 ran on commodity x86 hardware and the 
crash dumper worked on the various disk hardware I had occasion to use it on 
(mfm, scsi, ide), although one did need to make sure swap was larger than ram 
or bad things would happen. 8-{.  
