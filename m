Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWGXQtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWGXQtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWGXQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:49:32 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:51701 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932214AbWGXQtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:49:31 -0400
X-BigFish: V
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 0/2] OLPC + Geode fixups
Date: Mon, 24 Jul 2006 10:50:46 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165046.18787.23690.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:49:16.0606 (UTC)
 FILETIME=[19BB05E0:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA2586380800689-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches are in support of the OLPC project.  I sent these
patches before, but somewhere along the line I failed to correctly follow up.

The first one does some PCI ID cleanup (which is always nice), and the 
second allows one to disable VGA probing, which is essential when using
the OLPC LinuxBIOS which doesn't have VGA/VESA support (yay!).

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


