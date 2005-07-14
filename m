Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVGNB2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVGNB2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVGNB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:28:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:13487 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262319AbVGNB2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:28:00 -0400
Date: Thu, 14 Jul 2005 11:20:48 +1000
From: Nathan Scott <nathans@sgi.com>
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: linux-xfs@oss.sgi.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, tibor@altlinux.ru
Subject: Re: XFS corruption on move from xscale to i686
Message-ID: <20050714012048.GB937@frodo>
References: <1120756552.5298.10.camel@pc299.sam-solutions.net> <20050708042146.GA1679@frodo> <60868aed0507130822c2e9e97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60868aed0507130822c2e9e97@mail.gmail.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 06:22:28PM +0300, Yura Pakhuchiy wrote:
> I found patch by Greg Ungreger to fix this problem, but why it's still
> not in mainline? Or it's a gcc problem and should be fixed by gcc folks?

Yes, IIRC the patch was incorrect for other platforms, and it sure
looked like an arm-specific gcc problem (this was ages back, so
perhaps its fixed by now).

cheers.

-- 
Nathan
