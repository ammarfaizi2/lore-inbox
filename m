Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933941AbWK1BpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbWK1BpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933952AbWK1BpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:45:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:43662 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933941AbWK1BpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:45:18 -0500
Date: Mon, 27 Nov 2006 17:45:11 -0800
From: Greg KH <greg@kroah.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 6/7] driver core: Per-subsystem multithreaded probing.
Message-ID: <20061128014511.GA21263@kroah.com>
References: <20061127103514.6464e8c5@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127103514.6464e8c5@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 10:35:14AM +0100, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Make multithreaded probing work per subsystem instead of per driver.

Give me a little time to look over this and 7/7 hopefully later
tonight...

Your other patches look fine, I've added them to my tree.  Thanks for
resending them, I appreciate the persistance :)

greg k-h
