Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVDRRPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVDRRPC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 13:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVDRRPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 13:15:02 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:7643 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S262141AbVDRRO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 13:14:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC 1 of 9] patches to add diskdump functionality to block layer
Date: Mon, 18 Apr 2005 12:14:06 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC050F@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 1 of 9] patches to add diskdump functionality to block layer
Thread-Index: AcVELWPt3XdDnN/aT5aRNXOLJ2EEhQADDhTA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 18 Apr 2005 17:14:07.0125 (UTC) FILETIME=[074DAC50:01C5443A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christoph Hellwig [mailto:hch@infradead.org] 
> 
> This looks like a patch for Linux 2.4.  Such major changes for the
> 2.4 tree don't make sense anymore, especially for 
> functionality not even in Linux 2.6.
> 
This is for 2.4, I should have specified that in the Subject line. We
did this work because of customer demand and a request from a vendor. 
Marcelo, is this something that you be interested in adding to 2.4? If
not, I'll just submit this directly to the vendor.

Thanks,
mikem
> 
