Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVIWU1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVIWU1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVIWU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:27:12 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35694 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751248AbVIWU1K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:27:10 -0400
X-IronPort-AV: i="3.97,141,1125896400"; 
   d="scan'208"; a="316897889:sNHT26404800"
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update mechanism
Date: Fri, 23 Sep 2005 15:27:09 -0500
Message-ID: <597A2BC19EDD3C458F841E8724E92D4B973E1B@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update mechanism
Thread-index: AcXAd13NF82rBC7TQLugqliSRAX7uwABbSiQ
From: <Abhay_Salunke@Dell.com>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2005 20:27:10.0292 (UTC) FILETIME=[2CAD3140:01C5C07D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > -static ssize_t write_rbu_image_type(struct kobject *kobj, char
*buffer,
> >  -			loff_t pos, size_t count)
> >  +static ssize_t
> >  +write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t
pos,
> 
> This is contrary to the conventional kernel coding style.  I suggest
you
> not include all these layout changes.
Will fix my Lindent script and send another patch.
