Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSIEAWO>; Wed, 4 Sep 2002 20:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSIEAWO>; Wed, 4 Sep 2002 20:22:14 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:39434 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S316576AbSIEAWM> convert rfc822-to-8bit; Wed, 4 Sep 2002 20:22:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 17:26:45 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E012704DC@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUb9iezRJvFFk5RB++1z/SBqNigAAAm8Aw
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Sep 2002 00:26:45.0702 (UTC) FILETIME=[EA7F6E60:01C25472]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do apologize for using capital letters. I did not have 
any intention to offend you.
It was a long week for me

Sorry again
Regards,
Vlad

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, September 04, 2002 5:06 PM
> To: Libershteyn, Vladimir
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Problem on a kernel driver(SuSE, SMP)
> 
> 
> > Agree, I'll fix it(thanks for noticing that), but it's not 
> the point. 
> > The point is THIS INSTRUCTION HANGS. NO RETURN FROM IT.
> 
> I only deal with people who use CAPITAL LETTER RANTS when paid 8)
> 
> 
> Next guess is you didnt init the semaphore structure and it 
> happened to
> come out ok, but I find that unlikely to have worked in other cases.
> 
> 
> 
