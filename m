Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTI3XwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTI3Xuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:50:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:63719 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261797AbTI3Xuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:50:32 -0400
Date: Tue, 30 Sep 2003 16:32:51 -0700
From: Greg KH <greg@kroah.com>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] pci.ids for e1000
Message-ID: <20030930233251.GA21422@kroah.com>
References: <3F621965.4070106@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F621965.4070106@wanadoo.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 09:07:17PM +0200, Xose Vazquez Perez wrote:
> Jeff Garzik wrote:
> 
> > The general idea is to keep 2.4, 2.6, and pciids.sf.net in sync.
> 
> is there sync between 2.4, 2.6, and pciids.sf.net ?  ;-)
> 
> Linus and Marcelo should not accept patches against pci.ids,
> all updates should go to pciids.sf.net. And every X time
> to do a sync with 2.4 and 2.6.

I'd love to see a volunteer to try to sync these files up and routinely
send updates to the pci maintainers of the different kernel trees.

Anyone?

I also agree with David, it's completly acceptable for drivers to add
their ids to this file when they are added to the kernel tree.

thanks,

greg k-h
