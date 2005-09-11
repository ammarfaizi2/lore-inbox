Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVIKVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVIKVFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVIKVFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:05:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15335 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750887AbVIKVFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:05:21 -0400
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [2/3] Set compatibility flag for 4GB zone on IA64
Date: Sun, 11 Sep 2005 23:05:27 +0200
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, "Greg Edwards" <edwardsg@sgi.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509112305.28304.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 22:44, Luck, Tony wrote:

> What does this ZONE_DMA_IS_DMA32 thing do?

It just gives you the same behaviour as before when the DMA32 patchkit
from l-k is applied.

-Andi
