Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269222AbUIHX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbUIHX6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbUIHX5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:57:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:2009 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269204AbUIHXyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:54:35 -0400
Date: Wed, 8 Sep 2004 16:51:39 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use before NULL check in shpchp_ctrl
Message-ID: <20040908235139.GD8361@kroah.com>
References: <20040903211058.GW26419@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903211058.GW26419@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 10:10:58PM +0100, Dave Jones wrote:
> More fun found with the coverity checker.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Applied, thanks.

greg k-h
