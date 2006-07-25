Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWGYW3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWGYW3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGYW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:29:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932505AbWGYW3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:29:15 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 0 of 7] x86-64: Calgary IOMMU updates
Date: Wed, 26 Jul 2006 00:25:56 +0200
User-Agent: KMail/1.9.3
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <patchbomb.1153846590@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607260025.56903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 18:56, Muli Ben-Yehuda wrote:
> Hi Andi,
> 
> This patchset contains a few Calgary bug fixes (mostly in the error
> handling) and a few harmless associated cleanups (e.g., rearranging
> structures for better alignment). It would be good to get these,
> especially the bug fixes, into 2.6.18.

How do these patches relate to the two earlier patches that Jon sent?

2.6.18 is closed for anything but bug fixes for serious bugs.

-Andi

