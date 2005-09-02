Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVIBGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVIBGIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVIBGIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:08:35 -0400
Received: from web50208.mail.yahoo.com ([206.190.38.49]:39508 "HELO
	web50208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030245AbVIBGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:08:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lVp9rt5Iy7Ocsc99VEZmpFYD6neW+FVvirEFfa1BHrthA8pb5U5hfc3314p0toxsae2fxqqqNHgYGr4HrRobmLvUGR+Zkz1m4oxB1eb+xvtdfaYyrnHTXsf3zxVSUZjjUPJpmqDQJtiV2GszUls8cm+N1zaWreXN+laoQRaQM1g=  ;
Message-ID: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
Date: Thu, 1 Sep 2005 23:08:30 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: RE:  RFC: i386: kill !4KSTACKS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiswrapper and driverloader will not work reliably with 4k stacks.
This is because of the Windoze drivers they use, to which, obviously,
they do not have the source. Since quite a few laptops have built-in
wireless cards by companies who will not release an open-source driver,
or won't release specs, ndiswrapper and driverloader are the only way
to get these cards to work. 
  Please don't tell me to "get a linux-supported wireless card". I don't
want the clutter of an external wireless adapter sticking out of my laptop,
nor do I want to spend money on a card when I have a free and working solution.

Thank you.

-Alex

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
