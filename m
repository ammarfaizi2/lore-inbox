Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUCAUTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCAUTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:19:00 -0500
Received: from fmr05.intel.com ([134.134.136.6]:44958 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261424AbUCAUS7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:18:59 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Date: Mon, 1 Mar 2004 11:00:26 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010222A06C@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Thread-Index: AcP9LGy9DCYDtwk0RnOTuLLUfxW6jQCky7Rg
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Martin Bene" <martin.bene@icomedias.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2004 19:00:27.0296 (UTC) FILETIME=[7593C200:01C3FFBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz 
> CPU, Onboard e1000 Network interface. Any idea how I can get 
> the onboard NIC to work?

Martin, give 2.6.4-rc1 a try.  It removes a patch to e1000 that broke a
lot of folks with 875/CSA.

-scott
