Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTHTXZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTHTXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:25:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:45240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262345AbTHTXZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:25:34 -0400
Date: Wed, 20 Aug 2003 16:25:30 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] PCI: undo recent pci_setup_bridge() change
Message-ID: <20030820232530.GA5461@kroah.com>
References: <20030821024044.A954@pls.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821024044.A954@pls.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 02:40:44AM +0400, Ivan Kokshaysky wrote:
> That patch went into mainline by mistake - it was initial variant of a
> fix for the problem with disabled P2P bridges. Which has already been
> fixed properly in -test3.

Applied to my trees, and will send it on in a bit.

thanks,

greg k-h
