Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261569AbUJYGWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUJYGWT (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 25 Oct 2004 02:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUJYGWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:22:19 -0400
Received: from fmr12.intel.com ([134.134.136.15]:55432 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261569AbUJYGVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:21:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Buggy DSDTs policy ?
Date: Mon, 25 Oct 2004 14:21:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFE0@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Buggy DSDTs policy ?
Thread-Index: AcS4VRPVZDmcSROJSTuKokV7kHFJKQCBUAyQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pekka Pietikainen" <pp@ee.oulu.fi>,
        "Xavier Bestel" <xavier.bestel@free.fr>
Cc: "Onur Kucuk" <onur@delipenguen.net>,
        "Olivier Galibert" <galibert@pobox.com>,
        <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Oct 2004 06:21:09.0685 (UTC) FILETIME=[D1707E50:01C4BA5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes, sure. But real non-technical people won't replace their DSDT
>> either.
>Their distro could do it for them :-) A simple approach would be to
>store md5sums of known-bad dsdt's and xdeltas to fixed ones, and the 
>fixed one gets placed in /etc where mkinitrd automagically picks it up
>whenever a new kernel is installed.

I don't think distro can do that, because they are not the owner of
DSDT.


