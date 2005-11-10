Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVKJXxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVKJXxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKJXxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:53:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56496 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932147AbVKJXxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:53:45 -0500
Message-ID: <4373DD82.8010606@us.ibm.com>
Date: Thu, 10 Nov 2005 15:53:38 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Cleanup mm/slab.c v2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second take at cleaning up mm/slab.c.  Patch series has picked up 2 new
patches and dropped one old one.  The 2 new patches create new helper
functions, and I've dropped the patch to inline 3 functions after it was
deemed unecessary.

Appologies for the delay in getting version 2 out.  /me is easily
distracted by shiny things.

-Matt
