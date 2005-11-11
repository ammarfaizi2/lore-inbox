Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKKH36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKKH36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 02:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVKKH35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 02:29:57 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:34984 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751040AbVKKH35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 02:29:57 -0500
Date: Fri, 11 Nov 2005 09:29:41 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: kernel-janitors@lists.osdl.org, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Cleanup mm/slab.c v2
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0511110928490.2001@sbz-30.cs.Helsinki.FI>
References: <4373DD82.8010606@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Matthew Dobson wrote:
> Second take at cleaning up mm/slab.c.  Patch series has picked up 2 new
> patches and dropped one old one.  The 2 new patches create new helper
> functions, and I've dropped the patch to inline 3 functions after it was
> deemed unecessary.

Looks good to me. Thanks Matthew!

				Pekka
