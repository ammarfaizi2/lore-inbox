Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153906AbQCWMgw>; Thu, 23 Mar 2000 07:36:52 -0500
Received: by vger.rutgers.edu id <S153942AbQCWMgY>; Thu, 23 Mar 2000 07:36:24 -0500
Received: from mea.tmt.tele.fi ([194.252.70.162]:3185 "EHLO mea.tmt.tele.fi") by vger.rutgers.edu with ESMTP id <S153938AbQCWM2m>; Thu, 23 Mar 2000 07:28:42 -0500
Date: Thu, 23 Mar 2000 14:31:29 +0200
From: Matti Aarnio <matti.aarnio@sonera.fi>
To: linux-kernel@vger.rutgers.edu
Subject: [Semi-OT@Linux-kernel] CHECK your email routing!
Message-ID: <20000323143129.S13396@mea.tmt.tele.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

[ List FAQ keeper should add this there -- and list welcome messages
  should have it too..  ]

Folks,

  I am one of people supporting these mailinglists, and acting as
  one of assisting postmasters.

  Quite often I see things like what this summary report tells:
  
FAILED:
  <smtp cedar-republic.com edmond@cedar-republic.com 60000>: ...\
        <<- RCPT To:<edmond@cedar-republic.com>
        ->> 550 <edmond@cedar-republic.com>... we do not relay

  Feeding this address to a page at URL:
	http://www.zmailer.org/mxverify.html

  Yields information that ONE of their backup MX servers refuses
  to send email thru to them.  Thus whenever all other servers
  fail to be reachable, that one ruins their email connectivity.


  Do make sure YOU don't have this very problem!


/Matti Aarnio <matti.aarnio@sonera.fi>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
