Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWGZAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWGZAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWGZAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:07:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:3530 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030282AbWGZAHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:07:25 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH 0 of 7] x86-64: Calgary IOMMU updates
Date: Wed, 26 Jul 2006 02:06:08 +0200
User-Agent: KMail/1.9.3
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <patchbomb.1153846590@rhun.haifa.ibm.com> <200607260025.56903.ak@suse.de> <20060725230740.GF23966@us.ibm.com>
In-Reply-To: <20060725230740.GF23966@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607260206.08645.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > 
> > 2.6.18 is closed for anything but bug fixes for serious bugs.
> 
> This is mostly error path bugs and clean-up/code re-org (to save memory
> and make things more cache friendly).  The changes are mostly minor.

Doesn't sound very critical for .18 then and I will delay it to .19

-Andi
