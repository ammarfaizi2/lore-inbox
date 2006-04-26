Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWDZTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWDZTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDZTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:47:09 -0400
Received: from [198.99.130.12] ([198.99.130.12]:3522 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932326AbWDZTrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:47:08 -0400
Date: Wed, 26 Apr 2006 14:42:48 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Erich Focht <efocht@ess.nec.de>, Tony Luck <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, eranian@hpl.hp.com, davidm@hpl.hp.com,
       Ben Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 3/5] Remove redundant NULL checks before [kv]free - in  arch/
Message-ID: <20060426184248.GB9269@ccure.user-mode-linux.org>
References: <200604170328.42599.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604170328.42599.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:28:42AM +0200, Jesper Juhl wrote:
> Remove redundant NULL checks before [kv]free + small CodingStyle cleanup
> for arch/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

The UML bits are applied, thanks.

			Jeff
