Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWHBXRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWHBXRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHBXRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:17:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:1451 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932335AbWHBXRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:17:04 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 0 of 4] x8-64: Calgary: updates for CONFIG_IOMMU_DEBUG
Date: Thu, 3 Aug 2006 01:16:48 +0200
User-Agent: KMail/1.9.3
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <patchbomb.1154559547@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1154559547@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030116.48607.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 00:59, Muli Ben-Yehuda wrote:
> Hi Andi,
> 
> A few Calgary updates for CONFIG_IOMMU_DEBUG: print a message when
> CONFIG_IOMMU_DEBUG is on, remove dangerous bringup debugging code and
> only double check our bitmap handling if currently debugging.
> 
> Please apply, patches are againt mainline with all previous Calgary
> patches applied (which should apply cleanly to your tree).

Added thanks.

In the future please be a little bit more verbose in the changelog
department.

_Andi
