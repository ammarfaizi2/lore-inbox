Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUBTX5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUBTX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:57:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:31467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261436AbUBTX5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:57:06 -0500
Date: Fri, 20 Feb 2004 15:57:00 -0800
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040220235700.GB17875@kroah.com>
References: <20040219194610.GB13934@kroah.com> <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org> <20040220005237.GA7079@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220005237.GA7079@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 01:52:37AM +0100, Andries Brouwer wrote:
> On the other hand, if the goal is to find and eradicate all such
> ugly uses of explicit device numbers, Linus' idea to make it all
> random will certainly help.
> (But a big grep for st_rdev might be more efficient.)

That will be one goal of 2.7 :)

thanks,

greg k-h
