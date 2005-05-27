Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVE0DDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVE0DDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVE0DDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:03:16 -0400
Received: from ns1.s2io.com ([142.46.200.198]:55197 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S261865AbVE0DDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:03:00 -0400
Message-Id: <200505270302.j4R32lVG027513@guinness.s2io.com>
From: "Leonid Grossman" <leonid.grossman@neterion.com>
To: <netdev@oss.sgi.com>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Neterion(S2io) 10GbE Xframe Programming Manual posted
Date: Thu, 26 May 2005 20:02:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20050316123828.0eb78fd3@dxpl.pdx.osdl.net>
Thread-index: AcUqaCoHOAO/D8XARRqfYUJtF8+jWg39dEOQ
X-Spam-Score: -95.7
X-Spam-Outlook-Score: ()
X-Spam-Features: FORGED_MUA_OUTLOOK,IN_REP_TO,MISSING_OUTLOOK_NAME,MSG_ID_ADDED_BY_MTA_3,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For people interested in "s2io" 10GbE driver, the programming manual for
Xframe-I 10GbE Adapter 
is now available at ftp: ns1.s2io.com user: "linuxdocs" password: "HALdocs"

The relatively small delta between sw-compatible Xframe-II and Xframe-I is
not covered in the document,
but the current driver supports both adapters. Patches for the extra
Xframe-II features will be added over time; 
One of them (UDP Send Offload) was posted earlier today.

