Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRIHOXH>; Sat, 8 Sep 2001 10:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRIHOWz>; Sat, 8 Sep 2001 10:22:55 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:26126 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269718AbRIHOWk>; Sat, 8 Sep 2001 10:22:40 -0400
Date: 08 Sep 2001 14:42:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88VMRprXw-B@khms.westfalen.de>
In-Reply-To: <20010906151113.A29583@maggie.dt.e-technik.uni-dortmund.de>
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <oupg0a1wi9x.fsf@pigdrop.muc.suse.de> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel> <oupg0a1wi9x.fsf@pigdrop.muc.suse.de> <20010906151113.A29583@ma
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthias.andree@gmx.de (Matthias Andree)  wrote on 06.09.01 in <20010906151113.A29583@maggie.dt.e-technik.uni-dortmund.de>:

> Well, Postfix used to look at the addresses and deduce the network class
> for that,

The WHAT?!

Classes have been dead since around 1993!

> but there have been many complaints by people that this would
> get subnets wrong. A couple of months ago, Postfix has started to look
> up the netmasks as well.

Modern software trying to work with classes should not allowed on the  
Internet; people who don't know this should not allowed to write network  
software.


MfG Kai
