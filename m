Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRHFU7A>; Mon, 6 Aug 2001 16:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268563AbRHFU6v>; Mon, 6 Aug 2001 16:58:51 -0400
Received: from dsl254-096-012.nyc1.dsl.speakeasy.net ([216.254.96.12]:3556
	"EHLO mercury.infiniconsys.com") by vger.kernel.org with ESMTP
	id <S268140AbRHFU6c> convert rfc822-to-8bit; Mon, 6 Aug 2001 16:58:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Resources for SCSI, SRP, Infiniband?
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Mon, 6 Aug 2001 16:58:37 -0400
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB0C4C84@mercury.infiniconsys.com>
Thread-Topic: Resources for SCSI, SRP, Infiniband?
Thread-Index: AcEetqZBAESq6IV3QCqob25/Hwr6lwAA5kmw
From: "Heinz, Michael" <mheinz@infiniconsys.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Pete.


That's kind of the impression I was forming - nothing public for IB,
everything under the covers. Kind of silly, in the long run. 

As for the SCSI - thanks, at least I know I won't be breaking any rules
(since there aren't any... ;->)


Everybody loves a clown, but nobody will lend him money.

Michael "Pork Chop" Heinz
Infinicon Systems
610-205-0457 

-----Original Message-----
From: Pete Zaitcev [mailto:zaitcev@redhat.com]
Sent: Monday, August 06, 2001 4:14 PM
To: Heinz, Michael; linux-kernel
Subject: Re: Resources for SCSI, SRP, Infiniband?


> I'm making progress, but could someone direct me to a list of do's and

> don't's for SCSI drivers in 2.4?

Laugh, sadly.

> Also, anybody else looking at developing IB and or SRP?

Nobody does IB in the open, because hardware is not generally
available. Adapter manufacturers roll their proprietary stacks.
I work in a Trillian style effort (e.g. definitely to be opensourced
at a later date) - contact johnsonm at redhat if you are interested
in joining.

No SRP implementations exist that I know of, prorotypes may
be out there, coming from storage startups. AFAIK, Intel is
using a packetised SCSI mapping, at least Ashok Raj made
noises about it on IDF.

-- Pete

