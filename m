Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUKOJeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUKOJeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUKOJeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:34:19 -0500
Received: from fmr18.intel.com ([134.134.136.17]:8655 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261479AbUKOJeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:34:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [netdrvr] netdev-2.6 queue updated
Date: Mon, 15 Nov 2004 17:34:00 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD583B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [netdrvr] netdev-2.6 queue updated
Thread-Index: AcTK4AvrLwQgEPrBTA2P6fIEjREiCQAFV13Q
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
X-OriginalArrivalTime: 15 Nov 2004 09:34:01.0485 (UTC) FILETIME=[3D71CBD0:01C4CAF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The most notable thing is the addition of HostAP.

How about move HostAP 802.11 stack and crypt related files to
net/80211? It is generic and some other drivers (i.e. ipw2100) share
the code. Do you receive patches to do this?

Thanks,
-yi
