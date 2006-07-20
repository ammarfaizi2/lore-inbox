Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWGTFTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWGTFTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWGTFTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 01:19:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26854 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932567AbWGTFTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 01:19:30 -0400
Date: Wed, 19 Jul 2006 22:19:29 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Message-ID: <20060720051929.GB763333@sgi.com>
References: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 10:31:55AM -0500, John Keller wrote:
> Resend #2 changes include:
> 
> - use 'void __iomem *' for ioremap() return values,
>   and handle error cases.
> 
> sgiioc4.c had been recently converted to using mmio ops.
> There are still a few issues to cleanup.
> 
> Signed-off-by: jpk@sgi.com
Signed-off-by: jeremy@sgi.com
