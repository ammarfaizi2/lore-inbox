Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUGVTlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUGVTlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUGVTlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:41:04 -0400
Received: from cfcafwp.sgi.com ([192.48.179.6]:46205 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267164AbUGVTlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:41:00 -0400
Date: Thu, 22 Jul 2004 14:40:50 -0500
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pat Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code re-org
Message-ID: <20040722194050.GA797@lnx-holt.americas.sgi.com>
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com> <200407221357.53404.jbarnes@engr.sgi.com> <20040722192003.GA617@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722192003.GA617@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat,

I have a set of patches that cleanly applies against the
http://linux.bkbits.net/linux-2.5 bitkeeper tree using quilt.  They are
not available for the rest of the world yet.  Could you move them from
~holt/ioif to the project's ftp directory on oss.sgi.com?

Thanks,
Robin

PS:  I found a few small problems with the bte code and will soon have
another patch that fixes that up.  Specifically, there were changes
made to bte_error.c and pda.h that are undone by your patch.
