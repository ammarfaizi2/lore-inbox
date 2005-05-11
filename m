Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVEKPZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVEKPZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVEKPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:25:43 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:17273 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261419AbVEKPZW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:25:22 -0400
X-IronPort-AV: i="3.93,96,1115010000"; 
   d="scan'208"; a="260269666:sNHT26493604"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Date: Wed, 11 May 2005 10:25:11 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143BCF0328@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Thread-Index: AcVWD+CVpt2iIcjeS0aBmef9roeGEwALYN5Q
From: <Abhay_Salunke@Dell.com>
To: <xavier.bestel@free.fr>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 11 May 2005 15:25:12.0392 (UTC) FILETIME=[9FCCCC80:01C5563D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Xavier Bestel [mailto:xavier.bestel@free.fr]
> Sent: Wednesday, May 11, 2005 4:57 AM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; Andrew Morton; Domsch, Matt
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
> 
> Le mardi 10 mai 2005 à 17:05 -0500, Abhay Salunke a écrit :
> 
> > +2> Download the BIOS image by copying the image file to
> /sys/firmware/rbudata
> > +file.
> > +e.g. echo image.hdr > /sys/firmware/rbudata
> 
> Don't you mean 'cat' instead of 'echo' there ?
> 
> 	Xav
> 
Yes, thanks for correcting this typo.

Abhay
