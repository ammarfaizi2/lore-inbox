Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVCOWpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVCOWpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVCOWpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:45:16 -0500
Received: from fmr19.intel.com ([134.134.136.18]:21686 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261989AbVCOWl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:41:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Date: Tue, 15 Mar 2005 14:41:48 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080A5267@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUpr3+jBq24nGIVR2GjPxcrS0ledAAACI0Q
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 15 Mar 2005 22:41:49.0279 (UTC) FILETIME=[2CD0C6F0:01C529B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 15, 2005 2:38 PM Grant Grundler wrote:
>> >A co-worker made the following observation (I'm paraphrasing):
>> >	...this proposal does not deal with the Error Reporting ECN.
>> >	For example, they do not show the advisory non-fatal bit in
>> >	the correctable error status register.
>> 
>> Does he refer to the ECN update on the Received Error Bit[0] of the
>> Correctable Error Status Register and on the Training Error Bit[0] of
>> the Uncorrectable Error Status Register? If not, please clarify his
>> comments for us.

>Yes - I believe so.

Great! I will make changes to reflect this update. Thanks for pointing
it out.

Thanks,
Long
