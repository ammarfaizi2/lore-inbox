Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUJGKDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUJGKDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUJGKB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:01:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:22197 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269777AbUJGJ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:59:35 -0400
Date: Thu, 7 Oct 2004 11:54:23 +0200
From: Andi Kleen <ak@suse.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com, ak@suse.de
Subject: Re: [Patch] share i386/x86_64 intel cache descriptors table
Message-ID: <20041007095423.GC21807@wotan.suse.de>
References: <20041006184723.A10900@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006184723.A10900@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 06:47:23PM -0700, Siddha, Suresh B wrote:
> Some cache descriptors are missing from x86_64 table. So instead of
> copying from i386 code, here is a patch to share the table between i386 and
> x86_64.

Fine by me when the i386 change is accepted into mainline.

-Andi

