Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFNGmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFNGmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFNGmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:42:38 -0400
Received: from general.keba.co.at ([193.154.24.243]:44365 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261254AbVFNGmg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:42:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Date: Tue, 14 Jun 2005 08:42:37 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732323B@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Thread-Index: AcVwJsI1eBOLDvylQKqF56S3YsiiEgAhTA5w
From: "kus Kusche Klaus" <kus@keba.com>
To: "Serge Noiraud" <serge.noiraud@bull.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Ingo Molnar" <mingo@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was one of those who tried to get kgdb working.

Here I described how far I came:
http://www.ussg.iu.edu/hypermail/linux/kernel/0505.1/0700.html

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Serge Noiraud
> Sent: Monday, June 13, 2005 4:31 PM
> To: linux-kernel
> Cc: Ingo Molnar
> Subject: RT and kernel debugger ( 2.6.12rc6 + RT > 48-00 )
> 
> 
> Hi,
> 
> 	I would like to know what kernel debugger you propose 
> over the RT
> patch. I used to test kgdb, but since spinlock modification, 
> it doesn't
> work anymore.
> 
> Does someone work over RT to port a kernel debugger ?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
