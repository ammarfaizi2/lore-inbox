Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270003AbUJHOxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbUJHOxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUJHOxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:53:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:35018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270003AbUJHOxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:53:42 -0400
Date: Fri, 8 Oct 2004 07:23:06 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: block till hotplug is done?
Message-ID: <20041008142306.GA10236@kroah.com>
References: <1097005927.4953.4.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097005927.4953.4.camel@simulacron>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 09:52:07PM +0200, Andreas Jellinghaus wrote:
> Hi,
> 
> is there any way to block till all hotplug events are handled/
> the hotplug processes terminated?

No.  We've been over this many times before.  Please read the mailing
list archives and look at the /etc/dev.d/ interface for the solution to
this.

thanks,

greg k-h
