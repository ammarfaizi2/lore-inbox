Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270544AbTGNGNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270545AbTGNGNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:13:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:142 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270544AbTGNGNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:13:07 -0400
Date: Sun, 13 Jul 2003 23:22:17 -0700
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030714062217.GA20482@kroah.com>
References: <200307131839.49112.fredrik@dolda2000.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307131839.49112.fredrik@dolda2000.cjb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 06:39:49PM +0200, Fredrik Tolf wrote:
> Why does the input layer still not have on-demand module loading? How about 
> applying this?

What's wrong with the current hotplug interface for the input layer?  If
you want to implement this, add some input hotplug scripts to the
linux-hotplug package.

thanks,

greg k-h
