Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbUKDPZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUKDPZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKDPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:25:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:9374 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262270AbUKDPUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:20:04 -0500
Date: Wed, 3 Nov 2004 17:52:37 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: fix compile warning for USB w/oPM
Message-ID: <20041104015237.GA16864@kroah.com>
References: <20041020023803.GF8597@taniwha.stupidest.org> <20041020235056.GA16606@kroah.com> <20041021002935.GA13781@taniwha.stupidest.org> <20041021021329.GA27812@kroah.com> <20041103091049.GB22469@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091049.GB22469@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:10:49AM -0800, Chris Wedgwood wrote:
> Remove compile warning for USB w/o PM.
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> ---
> 
> This one I even tested...  sorry about before!

Already fixed in my tree from a patch from David Brownell.

thanks,

greg k-h
