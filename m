Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbULMUl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbULMUl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbULMUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:30:17 -0500
Received: from Volter-FW.ser.netvision.net.il ([212.143.107.30]:47961 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S262347AbULMUVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:21:55 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [openib-general] [PATCH][v3][17/21] Add IPoIB (IP-over-InfiniBand)driver
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 13 Dec 2004 22:19:09 +0200
Message-ID: <5CE025EE7D88BA4599A2C8FEFCF226F5175B0C@taurus.voltaire.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] [PATCH][v3][17/21] Add IPoIB (IP-over-InfiniBand)driver
Thread-Index: AcThP4iCp3eUgFs6Q32yzxzs66Z4HwAEXg88
From: "Hal Rosenstock" <halr@voltaire.com>
To: "Roland Dreier" <roland@topspin.com>, <linux-kernel@vger.kernel.org>
Cc: <netdev@oss.sgi.com>, <openib-general@openib.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

[You wrote:]
> The IPoIB protocol/encapsulation is described in the Internet-Drafts
>  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-architecture-04.txt
>  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-07.txt

The latest I-D is now http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-08.txt

Also, isn't DHCP over IB (http://www.ietf.org/internet-drafts/draft-ietf-ipoib-dhcp-over-infiniband-07.txt) 
also supported ? If so, is that part of this or some other patch being submitted ?

Thanks.

-- Hal
