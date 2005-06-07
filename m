Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVFGFV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVFGFV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVFGFV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:21:28 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:62309 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261721AbVFGFVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:21:22 -0400
Date: Mon, 6 Jun 2005 22:21:16 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050607052116.GC17734@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <52ekbfj9xy.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ekbfj9xy.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 05:18:49PM -0700, Roland Dreier wrote:
>     Greg> That's fine to disable msi, I don't have an issue with that.
>     Greg> I'm just getting pushback from some vendors as to why MSI
>     Greg> isn't explicitly enabled by default and I don't have any
>     Greg> solid answers.
> 
> Why don't those vendors push back on their own behalf, on public
> mailing lists?

Heh, that's always the question...  They are on these lists, and should
probably speak up.

Oh yeah, Tom, any opinions on this topic?  (note, Intel is not the
vendor pushing, just to squash any rumors...)

thanks,

greg k-h
