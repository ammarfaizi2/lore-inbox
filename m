Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKSVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKSVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUKSVvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:51:02 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:13308 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261600AbUKSVtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:49:08 -0500
Message-ID: <419E6A50.5060107@mvista.com>
Date: Fri, 19 Nov 2004 14:49:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Support for Marvell EV-64260[ab]-BP eval platform
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a line of evaluation platforms from Marvell 
that use the Marvell GT64260[ab] host bridges.

This patch depends on the Marvell host bridge support patch (mv64x60).

This patch is larger than 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/ev64260.patch

