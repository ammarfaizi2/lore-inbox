Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVCOVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVCOVzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCOVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:55:04 -0500
Received: from fmr20.intel.com ([134.134.136.19]:42888 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261897AbVCOVyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:54:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Date: Tue, 15 Mar 2005 13:54:32 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080A511B@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUpmwMWQC+Ed/KhSyq8JMI7lrKnjgADXf6w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 15 Mar 2005 21:54:40.0340 (UTC) FILETIME=[96A2F140:01C529A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 15, 2005 12:12 PM Grant Grundler wrote:
>Tom,
>A co-worker made the following observation (I'm paraphrasing):
>	...this proposal does not deal with the Error Reporting ECN.
>	For example, they do not show the advisory non-fatal bit in
>	the correctable error status register.

Does he refer to the ECN update on the Received Error Bit[0] of the
Correctable Error Status Register and on the Training Error Bit[0] of
the Uncorrectable Error Status Register? If not, please clarify his
comments for us.

Thanks,
Long
