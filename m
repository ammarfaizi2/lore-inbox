Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGAUUD>; Mon, 1 Jul 2002 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGAUUC>; Mon, 1 Jul 2002 16:20:02 -0400
Received: from adsl-64-170-199-186.dsl.snfc21.pacbell.net ([64.170.199.186]:44514
	"EHLO orion.ariodata.com") by vger.kernel.org with ESMTP
	id <S316465AbSGAUUB> convert rfc822-to-8bit; Mon, 1 Jul 2002 16:20:01 -0400
content-class: urn:content-classes:message
Subject: RE2: [OKS] Module removal
Date: Mon, 1 Jul 2002 13:21:57 -0700
Message-ID: <8A098FDFC6EED94B872CA2033711F86F0EC115@orion.ariodata.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: RE2: [OKS] Module removal
Thread-Index: AcIhPPHeyKy8lHtGT6uzDE+Vzju9ZQ==
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
From: "Michael Nguyen" <mnguyen@ariodata.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > 
> > The suggestion was made that kernel module removal be depreciated or
> > removed. I'd like to note that there are two common uses for this
> > capability, and the problems addressed by module removal should be
> > kept in mind. These are in addition to the PCMCIA issue raised.

I saw this mail flashes thru the reflector. It is worrying to know
that this great feature is on the discussion table for removal.

My humbly two cents, is that the Kernel Module is very much appreciative
in the Linux embedded development. We, in embedded development, write 
"Kernel Modules/Drivers" to run our hardware. The Kernel Module feature 
allows us to segregate the HW specific from the Linux, and it also
allows
us to upgrade the module code without reload of Linux. This approach is
very efficient for us in the embedded products.

I hope others can share this comment, and help keep this feature as is.

Reagards,
Michael.

