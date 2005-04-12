Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVDLVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVDLVtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVDLVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:46:52 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:45483 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S263015AbVDLVqP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:46:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 16:46:10 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F122164@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/pzefr/Eq1YTJR6OVBjscAKDzXwAAA5nA
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Matt Mackall" <mpm@selenic.com>
Cc: "Greg KH" <greg@kroah.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

The ball is in my court, because my wishes as a copyright holder are not
being honored.

Which is the right of Christoph because of the GPL, but it sure doesn't
help the end
users of said product.
Your claim that you are trying to "help" end users is bogus and just
plain wrong.
Period.

> As such, we make very little allowance
> for their concerns, especially when they stand in
> the way of improving things that _are_ in the kernel.

How is shipping a stripped down version of the driver, by yanking things
our customers want, improving the "things that are in the kernel"?

At any rate,
After thinking about this some more, I actually don't believe all this
will
be a problem on my end after all.

When the user installs my driver with all the extra features that our
customers
really want, I will simply check to see if jsm.ko exists, and ask the
user if I
can blow away the jsm.ko module.

So now, I think this thread can probably die a peaceful death.

Scott
