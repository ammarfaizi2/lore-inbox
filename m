Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUJOWqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUJOWqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJOWqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:46:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:56553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266613AbUJOWpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:45:49 -0400
Date: Fri, 15 Oct 2004 15:43:58 -0700
From: Greg KH <greg@kroah.com>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 038 release
Message-ID: <20041015224357.GB30319@kroah.com>
References: <416FC4E2.6000206@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FC4E2.6000206@0Bits.COM>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 04:38:58PM +0400, Mitch wrote:
> Also going from 036 to 038 broke centrino wireless ipw2200
> firmware autoloading. Removing
> 
> 	/etc/hotplug.d/default/05-wait_for_sysfs.hotplug
> 
> fixed the problem.

Fixed in the 039 release, sorry about this.

greg k-h
