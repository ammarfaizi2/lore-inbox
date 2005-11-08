Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965370AbVKHApY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbVKHApY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965648AbVKHApY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:45:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46984 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965370AbVKHApX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:45:23 -0500
Message-ID: <436FF51D.8080509@us.ibm.com>
Date: Mon, 07 Nov 2005 16:45:17 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Cleanup slab.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there was some (albeit very brief) discussion last week about the
need to cleanup mm/slab.c, I figured I'd post these patches.  I was
inspired to cleanup mm/slab.c since I'm working on a project (to be posted
shortly) that touched a bunch of slab code.  I found slab.c to be
inconsistent, to say the least.

-Matt
