Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUJZLJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUJZLJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUJZLJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:09:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262230AbUJZLHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:07:30 -0400
Date: Tue, 26 Oct 2004 06:34:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 2.4.28] delkin_cb: new carbus IDE driver
Message-ID: <20041026083411.GC24462@logos.cnet>
References: <417DBC0D.9050105@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417DBC0D.9050105@rtr.ca>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:53:01PM -0400, Mark Lord wrote:
> Marcelo,
> 
> This new driver is also ready to go into 2.4.xx.
> It is completely stand-alone, with no code impact
> to any existing drivers, and so should be pretty safe.

Ok I buy that, applied.

Thanks.

> Changes since last posting: fixed handling of module load errors.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> -- 
> Mark Lord
> (hdparm keeper & the original "Linux IDE Guy")
