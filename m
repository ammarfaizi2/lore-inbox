Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTEHO03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTEHO02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:26:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:37637 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261702AbTEHO02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:26:28 -0400
Date: Thu, 8 May 2003 15:39:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.69-uc1 (MMU-less fix ups)
Message-ID: <20030508153900.B9081@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F06CF6E.7090803@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F06CF6E.7090803@snapgear.com>; from gerg@snapgear.com on Sat, Jul 05, 2003 at 11:15:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 11:15:26PM +1000, Greg Ungerer wrote:
> Hi All,
> 
> Another update of the uClinux (MMU-less) fixups against 2.5.69.
> This includes some of the missing m5282 CPU support, and fixes
> gettimeofday() to be microsecond accurate.
> 
> You can get it at:

Any plans to submit patches to Linus so we'll have na updatodate
m68knommu in mainline again?

