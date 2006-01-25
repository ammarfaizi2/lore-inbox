Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWAYXWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWAYXWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWAYXWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:22:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:12982 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932213AbWAYXWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:22:22 -0500
Date: Wed, 25 Jan 2006 14:03:44 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unify sysfs device tree
Message-ID: <20060125220344.GA10082@kroah.com>
References: <20060113015652.GA30796@vrfy.org> <20060116134314.GA10813@vrfy.org> <20060125161006.GA30295@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125161006.GA30295@vrfy.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 05:10:06PM +0100, Kay Sievers wrote:
> 
> Unify sysfs device tree
> 
> Move device objects from /sys/class and /sys/block to /sys/devices and add
> ---

Seems like your description got cut off on, and you forgot a
Signed-off-by: line so I can take it and start merging it in :)

thanks,

greg k-h
