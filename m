Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUIHAVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUIHAVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIHAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:21:45 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:26639 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S268791AbUIHAVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:21:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: IDE class driver with SATA controllers
Date: Tue, 7 Sep 2004 17:21:35 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F96B2@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE class driver with SATA controllers
Thread-Index: AcSQJmWjwZB5f3hMR7uo0h+ADISUOwFErGwg
From: "Andrew Chew" <AChew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Sep 2004 00:23:33.0073 (UTC) FILETIME=[12E31410:01C4953A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff Garzik wrote:
> If you want to play, and don't care about lack of ATAPI support (i.e. 
> just disks), then it is possible today to do this.  #define 
> ATA_FORCE_PIO and play away :)

I don't see ATA_FORCE_PIO anywhere in the linux-2.6.9-rc1-bk14 tree.  Am
I looking for the wrong #define?
