Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWKBRcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWKBRcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWKBRcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:32:00 -0500
Received: from mail.suse.de ([195.135.220.2]:55731 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750871AbWKBRb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:31:59 -0500
From: Andi Kleen <ak@suse.de>
To: "bibo,mao" <bibo.mao@intel.com>
Subject: Re: [PATCH 1/5] i386 create e820.c to handle standard io/mem resources
Date: Thu, 2 Nov 2006 18:31:56 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <4540AA97.3030301@intel.com>
In-Reply-To: <4540AA97.3030301@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021831.56819.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 14:31, bibo,mao wrote:
> This patch creates new file named e820.c to hanle standard io/mem
> resources, moving request_standard_resources function from setup.c
> to e820.c. Also this patch modifies Makfile to compile file e820.c.

I dropped all these patches because they didn't apply anymore.
Can you please resubmit against latest kernel? Doing it in a single
patch is ok.

Thanks,
-Andi
