Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTGAPIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTGAPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:08:17 -0400
Received: from relay5.ftech.net ([195.200.0.100]:11431 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S262409AbTGAPIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:08:16 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25C962@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Krzysztof Halasa'" <khc@pm.waw.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.22-pre2
Date: Tue, 1 Jul 2003 16:22:37 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello,
	Yes please do that.  There are people who want it in.

Kevin Curtis
Linux Development
FarSite Communications Ltd
kevin.curtis@farsite.co.uk
tel:   +44 1256 330461
fax:  +44 1256 854931
http://www.farsite.co.uk

-----Original Message-----
From: Krzysztof Halasa [mailto:khc@pm.waw.pl]
Sent: 28 June 2003 00:39
To: Marcelo Tosatti
Cc: lkml
Subject: Re: Linux 2.4.22-pre2


Hi,

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.

What's wrong with the generic HDLC update then? Are you going to apply it?

ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch
or http://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch

Yes, it applies to 2.4.21-pre7 and later kernels, including 2.4.22-pre2.
I hope it will require "-R" to apply it to pre3...

TIA.
-- 
Krzysztof Halasa
Network Administrator
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
