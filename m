Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVDOIVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVDOIVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVDOIVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:21:41 -0400
Received: from web51409.mail.yahoo.com ([206.190.38.188]:28565 "HELO
	web51409.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261769AbVDOIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:20:49 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=TquXElgFDCkL8jJ+w0ErOFUiJ90wOe5+smmO2ODeXWnM4NQpeb471COd05B8/a6J6MOUQN0VKcceOTpsplnxCJxM/cDstbPqi3ChmHTEckTC1JZ7YeU+jl6fb9/Os64hsl7Y23exT9h48u3SIpbhpFFFwngjL+6SwKZ5Ycm5xkw=  ;
Message-ID: <20050415082048.1497.qmail@web51409.mail.yahoo.com>
Date: Fri, 15 Apr 2005 10:20:48 +0200 (CEST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: 2.6 PCMCIA/USB question
To: kernel <linux-kernel@vger.kernel.org>,
       linux-usb-user <linux-usb-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I have a question that I could not figure out from other sources. I have
the following hardware: an integrated CardBus USB host adapter with a
connected USB serial device with three interfaces (normally
ttyUSB0...ttyUSB2). Now I want to use 3 of these devices (remember: they
are integrated, so I can't just plug the USB device onto the same host
adapter). I know device A is in CardBus slot 1, device B is in CardBus
slot 2 and so on. 

Now the question: How do I figure out which ttyUSBx belongs to which
device?

Thanks in advance
  Joerg


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
