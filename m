Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267309AbUGNDHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267309AbUGNDHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUGNDHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:07:03 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:54210 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S267309AbUGNDGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:06:42 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
Subject: Fwd: Mail System Error - Returned Mail
Date: Tue, 13 Jul 2004 23:06:39 -0400
User-Agent: KMail/1.6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/MK9AnEJPj/pzdJ"
Message-Id: <200407132306.39569.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.57.208] at Tue, 13 Jul 2004 22:06:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/MK9AnEJPj/pzdJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings;

I'm getting a lot of these bounces, any good reason?

----------  Forwarded Message  ----------

Subject: Mail System Error - Returned Mail
Date: Tuesday 13 July 2004 13:34
From: Mail Administrator <Postmaster@verizon.net>
To: gene.heskett@verizon.net

This Message was undeliverable due to the following reason:

Your message was not delivered because the destination computer was
not found.  Carefully check that it was spelled correctly and try
sending it again if there were any mistakes.

It is also possible that a network problem caused this situation,
so if you are sure the address is correct you might want to try to
send it again.  If the problem continues, contact your friendly
system administrator.

     Host vger.kernel.org not found

The following recipients did not receive this message:

     <linux-kernel@vger.kernel.org>

Please reply to Postmaster@verizon.net
if you feel this message to be in error.

-------------------------------------------------------



-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.

--Boundary-00=_/MK9AnEJPj/pzdJ
Content-Type: message/delivery-status;
  charset="us-ascii";
  name=" "
Content-Transfer-Encoding: 7bit

Reporting-MTA: dns; out005.verizon.net
Arrival-Date: Tue, 13 Jul 2004 12:34:08 -0500
Received-From-MTA: dns; coyote.coyote.den (151.205.57.208)

Final-Recipient: RFC822; <linux-kernel@vgr.kernel.org>
Action: failed
Status: 5.1.2
Remote-MTA: dns; vgr.kernel.org

--Boundary-00=_/MK9AnEJPj/pzdJ
Content-Type: message/rfc822;
  charset="us-ascii";
  name=" "
Content-Transfer-Encoding: 8bit

Received: from coyote.coyote.den ([151.205.57.208]) by out005.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040713173408.GBTA3910.out005.verizon.net@coyote.coyote.den>
          for <linux-kernel@vgr.kernel.org>;
          Tue, 13 Jul 2004 12:34:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vgr.kernel.org
Subject: Re: SATA disk device naming ?
Date: Tue, 13 Jul 2004 13:34:07 -0400
User-Agent: KMail/1.6
References: <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407131334.07256.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.57.208] at Tue, 13 Jul 2004 12:34:08 -0500

On Tuesday 13 July 2004 12:23, Ricky Beam wrote:
>On Tue, 13 Jul 2004, Eric D. Mudama wrote:
>>... "root=LABEL=/" ...
>
>I've seen the LABEL method not work at all. (2.6.7-rc3 on the
> wikipedia servers.)
>
>--Ricky
>
It was un-reliable enough here that I've discontinued its use.  There 
are two things wrong with it that I can see, first being that it 
doesn't always work, and 2nd, there appears to be no way to x-ref 
back so that you can see that its /dev/hda7 that is your /usr alias.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.

--Boundary-00=_/MK9AnEJPj/pzdJ--
