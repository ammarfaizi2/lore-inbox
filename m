Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUIXNXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUIXNXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUIXNXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:23:09 -0400
Received: from [142.46.200.198] ([142.46.200.198]:9889 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S268735AbUIXNXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:23:05 -0400
Message-Id: <200409241321.i8ODLf39012346@guinness.s2io.com>
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Lennert Buytenhek'" <buytenh@wantstofly.org>
Cc: "'David S. Miller'" <davem@davemloft.net>,
       "'Jeff Garzik'" <jgarzik@pobox.com>, <alan@lxorguk.ukuu.org.uk>,
       <paul@clubi.ie>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: The ultimate TOE design
Date: Fri, 24 Sep 2004 06:21:35 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSiN3ouJCXNcKFtTaC0s3q11RKVmAAATZSA
In-Reply-To: <20040924130738.GB24093@xi.wantstofly.org>
X-Spam-Score: -103.3
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_10,FORGED_MUA_OUTLOOK,IN_REP_TO,MISSING_OUTLOOK_NAME,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Lennert Buytenhek [mailto:buytenh@wantstofly.org] 
> Sent: Friday, September 24, 2004 6:08 AM
> To: Leonid Grossman
> Cc: 'David S. Miller'; 'Jeff Garzik'; 
> alan@lxorguk.ukuu.org.uk; paul@clubi.ie; netdev@oss.sgi.com; 
> linux-kernel@vger.kernel.org
> Subject: Re: The ultimate TOE design
> 
> On Wed, Sep 15, 2004 at 04:29:45PM -0700, Leonid Grossman wrote:
> 
> > And at 10GbE, embedded CPUs just don't cut it - it has to be custom 
> > ASIC (granted, with some means to simplify debugging and reduce the 
> > risk of hw bugs and TCP changes).
> 
> Intel's IXP2800 can do 10GbE.

Hi Lennert,
I was referring to the server side. 
One can certanly build a 10GbE box based on IPX2800 (or some other parts),
but at 17-25W it is not usable in NICs since the entire PCI card budget is
less than that - nothing left for 10GbE PHY, memory, etc.
Leonid

> 
> http://www.intel.com/design/network/products/npfamily/ixp2800.htm
> 
> 
> --L
> 

