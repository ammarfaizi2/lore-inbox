Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUFPEJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUFPEJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUFPEJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:09:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:60136 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266138AbUFPEJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:09:42 -0400
Date: Tue, 15 Jun 2004 21:08:00 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export pm_suspend
Message-ID: <20040616040758.GA6521@kroah.com>
References: <20040616011311.GA9256@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616011311.GA9256@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 06:13:11PM -0700, Todd Poynor wrote:
> Allow modules to request system suspend via the in-kernel interface, if
> desired.

And who would be so desiring?  I don't see any in-kernel code that needs
this.  Care to also submit the code that needs this?

thanks,

greg k-h
