Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTDYOiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTDYOiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:38:25 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:56594 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263206AbTDYOiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:38:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
Date: Fri, 25 Apr 2003 09:50:28 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106404744CFF@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss patches for 2.4.21-rc1, 4 of 4
Thread-Index: AcMLM9l57xCg6MEzQ0Gmm7XHn/dXnQABbbZQ
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <arjanv@redhat.com>, "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
X-OriginalArrivalTime: 25 Apr 2003 14:50:29.0601 (UTC) FILETIME=[03C8DD10:01C30B3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Cameron, lots of people told you numerous times that pci_alloc_consitent
> is guaranteed to return 32 bit addresses by the API, see
> Documentation/DMA-mapping.txt for the API definition.

Ok.  You won't have to remind me again, since, as it happens,
today is officially my last day at HP doing anything in the linux kernel.
(I'm still at HP, just doing something else now.)

Thanks,

-- steve

