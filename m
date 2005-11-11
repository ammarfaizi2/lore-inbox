Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVKKVxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVKKVxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVKKVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:53:48 -0500
Received: from mail-haw.bigfish.com ([12.129.199.61]:40392 "EHLO
	mail54-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751246AbVKKVxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:53:47 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [Question] PCI device memory management
Date: Fri, 11 Nov 2005 16:53:43 -0500
Message-ID: <18860D00A1C724419B900535DB985FB4016140E0@torcaexmb2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Question] PCI device memory management
Thread-Index: AcXnCmJ7lr6g/vCRTWeRJ8+Dtg5Odg==
From: "Alex Song" <asong@ati.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Nov 2005 21:53:45.0279 (UTC) FILETIME=[635F0CF0:01C5E70A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our PCI device has a lot of memory and we have to provide memory
management function for it. 

Does kernel already have this mechanism in place?

Or we have to manage it on our own?

Thanks a lot,

Alex

