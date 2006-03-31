Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWCaLCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWCaLCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWCaLCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:02:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17709 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751319AbWCaLCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:02:33 -0500
Date: Fri, 31 Mar 2006 13:02:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
Message-ID: <20060331110233.GM14022@suse.de>
References: <20060331040613.GA23511@havoc.gtf.org> <1143802879.3053.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143802879.3053.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Arjan van de Ven wrote:
> On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
> > Woe be unto he who builds their filesystems as modules.
> 
> 
> since splice support is highly linux specific and new.. shouldn't these
> be _GPL exports?

Yes they should, I'll add that to the current splice tree.

-- 
Jens Axboe

