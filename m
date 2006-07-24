Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWGXRVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWGXRVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:21:48 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:58485 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932227AbWGXRVr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:21:47 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 0/4] OLPC + Geode GX framebuffer updates
Date: Mon, 24 Jul 2006 10:54:54 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165454.18822.30310.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:51:55.0861 (UTC)
 FILETIME=[78A76850:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA25210Y8101923-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds updates to the GXFB driver to support the OLPC
effort.  These were sent before, but I didn't correctly follow up like I 
should have.

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


