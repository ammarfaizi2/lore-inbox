Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUHFTuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUHFTuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUHFTsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:48:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:63957 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268246AbUHFTrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:47:49 -0400
Date: Fri, 6 Aug 2004 12:47:29 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device class reference counting
Message-ID: <20040806194729.GA25345@kroah.com>
References: <200407301803.00269.thomas.koeller@baslerweb.com> <20040805224656.GA22545@kroah.com> <200408061137.47099.thomas.koeller@baslerweb.com> <200408061143.47858.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061143.47858.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 11:43:47AM +0200, Thomas Koeller wrote:
> Sorry,
> 
> seems the patch got messsed up somehow, so I am
> resending it:

This patch looks good.  But it has the tabs stripped out of it, and no
Signed-off-by: line.  Care to resend it with that fixed up?

thanks,

greg k-h
