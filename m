Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWHRKNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWHRKNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWHRKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:13:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:10733 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751339AbWHRKNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:13:49 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 0/5] -fstack-protector feature for the kernel (try 2)
Date: Fri, 18 Aug 2006 13:15:35 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
In-Reply-To: <1155746902.3023.63.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181315.35536.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 18:48, Arjan van de Ven wrote:
> This patch series adds support for the gcc -fstack-protector feature to
> the kernel. While gcc 4.1 supports this feature for userspace, the patches
> to support it for the kernel only got added to the gcc tree on 27/7/2006
> (eg for 4.2); it is expected that several distributors will backport this
> patch to their 4.1 gcc versions. (For those who want to know more, see gcc
> PR 28281)

FWIW -- my queue for 2.6.19 is already quite full and I'm
in the stabilization phase for the merge.

I will merge these patches post the 2.6.19 merge window into
my tree for .20.

-Andi

