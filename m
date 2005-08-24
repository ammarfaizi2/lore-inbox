Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVHXRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVHXRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVHXRDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:03:24 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:17672 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751210AbVHXRDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:03:23 -0400
Date: Wed, 24 Aug 2005 18:02:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumar Gala <galak@freescale.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 06/15] mips: remove use of asm/segment.h
Message-ID: <20050824170259.GF2783@linux-mips.org>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:54:27AM -0500, Kumar Gala wrote:

> Removed MIPS architecture specific users of asm/segment.h and
> asm-mips/segment.h itself

Thanks, applied.

  Ralf
