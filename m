Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSI0P5D>; Fri, 27 Sep 2002 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbSI0P5D>; Fri, 27 Sep 2002 11:57:03 -0400
Received: from [198.70.193.2] ([198.70.193.2]:57711 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id <S261725AbSI0P5C> convert rfc822-to-8bit;
	Fri, 27 Sep 2002 11:57:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] deadline io scheduler
Date: Fri, 27 Sep 2002 09:01:20 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B004F771@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] deadline io scheduler
Thread-Index: AcJl6uvF3GL9SX0BSEuvNaJ1xe81WAAUl2vw
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Andrew Vasquez" <praka@san.rr.com>
Cc: "Mike Anderson" <andmike@us.ibm.com>,
       "Michael Clark" <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, <wli@holomorphy.com>,
       <axboe@suse.de>, <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <patmans@us.ibm.com>
X-OriginalArrivalTime: 27 Sep 2002 16:02:08.0969 (UTC) FILETIME=[3BA8DB90:01C2663F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Vasquez wrote:
> > I hope this helps to clearup some of the haze and ambiguity
> > surrounding QLogic's work with the 6.x series driver, and perhaps
> > at the same time, prepares a medium for discussion regarding the 6.x
> > series driver.
> 
> Wow, thanks for all that information, and it's great that you've 
> integrated Arjan's work and feedback.
> 
> There is one big question left unanswered...  Where can the 
> source for 
> the latest version with all this wonderful stuff be found?  
> :)  I don't 
> see a URL even for 6.01b5.
> 
Sure, the 6.01b5 tarball can be found at:

	http://download.qlogic.com/drivers/5642/qla2x00-v6.1b5-dist.tgz

In general all QLogic drivers are available from the following URL:

	http://www.qlogic.com/support/drivers_software.asp

In my mind, a larger question is determining a balance between the 
'Release Early, release often' mantra of Linux development and the 
'kinder, more conservative pace' of business.  For example, If we 
cannot setup a 'patch/pre-beta' web-site locally at QLogic, I've 
considered starting a SourceForge project or hosting it locally 
through my ISP. 

Regards,
Andrew Vasquez
