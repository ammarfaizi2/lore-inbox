Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbVLASqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbVLASqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbVLASqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:46:30 -0500
Received: from magic.adaptec.com ([216.52.22.17]:44968 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750700AbVLASq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:46:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Date: Thu, 1 Dec 2005 13:46:07 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E9A886@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Thread-Index: AcX2n506rLm+KHEwQIKnu7HdUmdJcgABk36w
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       "Chris McDermott" <lcm@us.ibm.com>,
       "Luvella McFadden" <luvella@us.ibm.com>,
       "AJ Johnson" <blujuice@us.ibm.com>,
       "Kevin Stansell" <kstansel@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <Mauelshagen@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik [mailto:jgarzik@pobox.com] sez:
> All throughout development, before Justin had written a 
> single line of code, he was told to do things via Device Mapper.

He did not strictly write the emd code, it was written years earlier by
a team. It's release was the result of it being placed on his lap
submit.

As I said, it all ended up being an unfortunate timing of events with
unexpected side effects. At each instant of time it has always been
clear what to do ...

2005? We tried to set up a case for ROI for the support of a dmraid
plugin. I am merely a JAFO to that process trying to push it along.

Sincerely -- Mark Salyzyn


