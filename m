Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKSVpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKSVpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUKSVpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:45:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21236 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261596AbUKSVnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:43:35 -0500
Message-ID: <419E6900.5070001@mvista.com>
Date: Fri, 19 Nov 2004 14:43:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Marvell host bridge support (mv64x60)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds core support for a line of host bridges from Marvell 
(formerly Galileo).  This code has been tested with a GT64260a, 
GT64260b, MV64360, and MV64460.  Patches for platforms that use these 
bridges will be sent separately.

The patch is rather large so a link is provided.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/mv64x60.patch

