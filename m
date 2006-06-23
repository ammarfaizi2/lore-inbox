Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWFWQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWFWQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWFWQ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:56:05 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:33741 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751783AbWFWQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:56:03 -0400
X-BigFish: V
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Fri, 23 Jun 2006 11:00:58 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org
Subject: [GIT PATCH] Geode patches for 2.6.17
Message-ID: <20060623170058.GA12819@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 23 Jun 2006 16:55:49.0543 (UTC)
 FILETIME=[E1223370:01C696E5]
X-WSS-ID: 6882C29E31G3579734-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - 

Please consider pulling from:
git://git.infradead.net/users/jcrouse/geode.git linus-upstream

This is the new home for patches for the AMD Geode family of processors.

For 2.6.18, we offer up patches to support the One Laptop
Per Child effort - namely framebuffer tweaks, plus an attempt to remove
automagic probing of VGA registers (which we don't have on the OLPC
platform).

Here is the shortlog:

Jordan Crouse:
      GEODE: Update and fixup the PCI IDs for the CS5535
      FB: Get the Geode GX frambuffer size from the BIOS
      Add a configuration option to avoid automatically probing VGA
      gxfb: Fixups for the AMD Geode GX framebuffer driver

--
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


