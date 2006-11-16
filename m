Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162102AbWKPARX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162102AbWKPARX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162103AbWKPARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:17:23 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:20443 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1162102AbWKPARV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:17:21 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 16:17:10 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907205@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ALSA: hda-intel - Disable MSI support by default
Thread-Index: AccI+G+74GXGy7WIQ3ad7MeRPzzpxAAG1Hgw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Olivier Nicolas" <olivn@trollprod.org>,
       "Linus Torvalds" <torvalds@osdl.org>
cc: "Mws" <mws@twisted-brains.org>, "Jeff Garzik" <jeff@garzik.org>,
       "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
X-OriginalArrivalTime: 16 Nov 2006 00:17:11.0184 (UTC)
 FILETIME=[8F51B100:01C70914]
X-WSS-ID: 6945718D1WC484431-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried latest git and one MCP55+IO55 and had_intel, ALC883 codec
MB.

It works well with routeirq or not.

The BIOS disable the MSI cap.

YH


