Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTIVOlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTIVOlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:41:11 -0400
Received: from fmr09.intel.com ([192.52.57.35]:7651 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263161AbTIVOlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:41:08 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: HT not working by default since 2.4.22
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 22 Sep 2003 07:41:01 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017334142D@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not working by default since 2.4.22
Thread-Index: AcOA5+XTcYKZzVP8SnaRY0syq/ss1QAL33eA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 22 Sep 2003 14:41:02.0603 (UTC) FILETIME=[8BCA55B0:01C38117]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we agreed on that, and Len should be working on this.

Thanks,
Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Marcelo Tosatti
> Sent: Monday, September 22, 2003 2:01 AM
> To: linux-kernel@vger.kernel.org; Brown, Len; Alan Cox
> Subject: HT not working by default since 2.4.22
> 
> 
> Hi,
> 
> Ive received a few complaints that HT, starting from 2.4.22, needs
ACPI
> enabled. Users who had HT working now have to use ACPI and they didnt
> before.
> 
> We should have HT working AUTOMATICALLY without ACPI enabled and
WITHOUT
> any special boot option, as before.
> 
> Please lets fix that up
> 
> Len?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
