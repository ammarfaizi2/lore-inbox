Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWE1Hpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWE1Hpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWE1Hpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:45:35 -0400
Received: from 1in1.de ([85.214.39.241]:35000 "EHLO 1in1.de")
	by vger.kernel.org with ESMTP id S932079AbWE1Hpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:45:34 -0400
Message-ID: <44795515.90301@1in1.de>
Date: Sun, 28 May 2006 09:45:25 +0200
From: =?ISO-8859-1?Q?Jens_G=F6tze?= <jens.goetze@1in1.de>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux and Wireless USB Adaptor
References: <44793F44.1040603@perkel.com> <447946F8.9090407@1in1.de> <20060528072140.GB4108@ucw.cz>
In-Reply-To: <20060528072140.GB4108@ucw.cz>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=DA519E6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam: no
X-note: out-remsmtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

'nice' is everything what works fine as a solution. Therefore, I would
say that the ndiswrapper is nice, if the case is that no Linux Driver is
available. And if you have no time or the knowledge (programming or chip
set information) to implement a driver by your own, then is the
ndiswrapper a good solution.
Yes, the design is not the best, but it works or not?! ;-)

Regards,
Jens

Pavel Machek wrote:
> On Sun 28-05-06 08:45:12, Jens G?tze wrote:
>> Hello Marc,
>>
>> I would try ndiswrapper (http://ndiswrapper.sf.net), because it is the
>> easiest way to run a USB Wireless LAN adapter. The ndiswrapper is a nice
>> driver, which allows to run Windows NDIS Driver under Linux. Therefore,
> 
> For some very obscure definition of 'nice'...  
> 
> Avoid ndiswrapper, it is broken by design.
> 							Pavel
